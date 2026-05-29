$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $ProjectRoot

function Invoke-Step {
    param(
        [string]$Name,
        [scriptblock]$Command
    )

    Write-Host ""
    Write-Host "==> $Name"
    & $Command
}

function Wait-ForEndpoint {
    param(
        [string]$Url,
        [string]$Method = "GET",
        [int]$Attempts = 30,
        [int]$DelaySeconds = 2
    )

    for ($attempt = 1; $attempt -le $Attempts; $attempt++) {
        try {
            return Invoke-RestMethod -Method $Method -Uri $Url
        } catch {
            if ($attempt -eq $Attempts) {
                throw
            }

            Start-Sleep -Seconds $DelaySeconds
        }
    }
}

Invoke-Step "Validate Docker Compose file" {
    docker compose config | Out-Null
}

Invoke-Step "Build and start stack" {
    docker compose up -d --build
}

Invoke-Step "Wait for app health" {
    Wait-ForEndpoint -Url "http://127.0.0.1:5000/health" | ConvertTo-Json
}

Invoke-Step "Wait for database health" {
    Wait-ForEndpoint -Url "http://127.0.0.1:5000/db/health" | ConvertTo-Json -Depth 5
}

Invoke-Step "Record a visit" {
    Wait-ForEndpoint -Method "POST" -Url "http://127.0.0.1:5000/visits" | ConvertTo-Json -Depth 5
}

Invoke-Step "Read visit count" {
    Wait-ForEndpoint -Url "http://127.0.0.1:5000/visits" | ConvertTo-Json -Depth 5
}

Invoke-Step "Show container status" {
    docker compose ps
}

Write-Host ""
Write-Host "Stack verification completed successfully."
