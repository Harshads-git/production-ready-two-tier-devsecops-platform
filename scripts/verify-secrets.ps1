$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $ProjectRoot

Write-Host "==> Check for local env files"
$envFiles = Get-ChildItem -Force -File -Filter ".env*" | Where-Object { $_.Name -ne ".env.example" }
if ($envFiles) {
    $envFiles | Select-Object Name
    throw "Local env files must not be committed."
}

Write-Host "==> Check staged and tracked files for obvious placeholder leaks"
git grep -n "AWS_SECRET_ACCESS_KEY\\|BEGIN RSA PRIVATE KEY\\|BEGIN OPENSSH PRIVATE KEY\\|DATABASE_PASSWORD=.*[^example]" -- . ":!.env.example"
if ($LASTEXITCODE -eq 0) {
    throw "Potential secret-like value found. Review output above."
}

Write-Host "Secret hygiene verification completed successfully."

