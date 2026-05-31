$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $ProjectRoot

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

Write-Host "==> Python version"
Invoke-Checked python --version

Write-Host ""
Write-Host "==> Install dependencies"
Invoke-Checked python -m pip install --requirement app\requirements.txt

Write-Host ""
Write-Host "==> Run pytest"
Invoke-Checked pytest

Write-Host ""
Write-Host "CI-equivalent local verification completed successfully."
