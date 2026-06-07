$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $ProjectRoot

$ImageTag = "two-tier-devsecops-app:vulnerability-scan"

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

if (-not (Get-Command trivy -ErrorAction SilentlyContinue)) {
    throw "Trivy is not installed. Install it from https://trivy.dev/ before running local vulnerability scans."
}

Write-Host "==> Trivy version"
Invoke-Checked trivy --version

Write-Host ""
Write-Host "==> Filesystem vulnerability scan"
Invoke-Checked trivy fs --severity HIGH,CRITICAL --exit-code 1 .

Write-Host ""
Write-Host "==> Build Docker image for scan"
Invoke-Checked docker build --tag $ImageTag .

Write-Host ""
Write-Host "==> Container image vulnerability scan"
Invoke-Checked trivy image --severity HIGH,CRITICAL --exit-code 1 $ImageTag

Write-Host ""
Write-Host "Vulnerability verification completed successfully."

