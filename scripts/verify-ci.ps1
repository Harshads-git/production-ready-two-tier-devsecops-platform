$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $ProjectRoot

Write-Host "==> Python version"
python --version

Write-Host ""
Write-Host "==> Install dependencies"
python -m pip install --requirement app\requirements.txt

Write-Host ""
Write-Host "==> Run pytest"
pytest

Write-Host ""
Write-Host "CI-equivalent local verification completed successfully."

