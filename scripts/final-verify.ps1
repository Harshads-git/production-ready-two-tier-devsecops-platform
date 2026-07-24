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

Invoke-Step "Python tests" {
    powershell -ExecutionPolicy Bypass -File .\scripts\verify-ci.ps1
}

Invoke-Step "Secret hygiene" {
    powershell -ExecutionPolicy Bypass -File .\scripts\verify-secrets.ps1
}

Invoke-Step "Jenkinsfile structure" {
    powershell -ExecutionPolicy Bypass -File .\scripts\verify-jenkinsfile.ps1
}

Invoke-Step "Docker Compose config" {
    docker compose config | Out-Null
}

Invoke-Step "Terraform formatting check" {
    if (Get-Command terraform -ErrorAction SilentlyContinue) {
        terraform -chdir=infra\terraform fmt -check
    } else {
        Write-Host "Terraform is not installed locally; skipping Terraform fmt check."
    }
}

Write-Host ""
Write-Host "Final project verification completed successfully."
