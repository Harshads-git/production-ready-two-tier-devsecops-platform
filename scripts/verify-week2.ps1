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

Invoke-Step "Run Python CI verification" {
    powershell -ExecutionPolicy Bypass -File .\scripts\verify-ci.ps1
}

Invoke-Step "Run secret hygiene verification" {
    powershell -ExecutionPolicy Bypass -File .\scripts\verify-secrets.ps1
}

Invoke-Step "Run Jenkinsfile structure verification" {
    powershell -ExecutionPolicy Bypass -File .\scripts\verify-jenkinsfile.ps1
}

Invoke-Step "Validate Docker Compose config" {
    docker compose config | Out-Null
}

Write-Host ""
Write-Host "Week 2 verification completed successfully."

