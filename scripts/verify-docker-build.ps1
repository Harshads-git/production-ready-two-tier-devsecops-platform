$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $ProjectRoot

$ImageTag = "two-tier-devsecops-app:local-verify"

function Invoke-Checked {
    param(
        [string]$Command,
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$CommandArgs
    )

    & $Command @CommandArgs
    if ($LASTEXITCODE -ne 0) {
        throw "Command failed: $Command $CommandArgs"
    }
}

Write-Host "==> Docker version"
Invoke-Checked docker --version
Invoke-Checked docker compose version

Write-Host ""
Write-Host "==> Docker engine"
Invoke-Checked docker info --format "Server version: {{.ServerVersion}}"

Write-Host ""
Write-Host "==> Validate Compose file"
Invoke-Checked docker compose config

Write-Host ""
Write-Host "==> Build application image"
Invoke-Checked docker build --tag $ImageTag .

Write-Host ""
Write-Host "==> Inspect built image"
Invoke-Checked docker image inspect $ImageTag --format "Image ID: {{.Id}}"

Write-Host ""
Write-Host "Docker build verification completed successfully."
