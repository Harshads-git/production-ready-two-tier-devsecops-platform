$ErrorActionPreference = "Continue"

$ProjectRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $ProjectRoot

Write-Host "==> Docker version"
docker --version
docker compose version

Write-Host ""
Write-Host "==> Docker engine"
docker info

Write-Host ""
Write-Host "==> Compose config"
docker compose config

Write-Host ""
Write-Host "==> Containers"
docker compose ps

Write-Host ""
Write-Host "==> App logs"
docker compose logs --tail=120 app

Write-Host ""
Write-Host "==> Database logs"
docker compose logs --tail=120 db
