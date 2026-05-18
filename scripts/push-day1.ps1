param(
    [string]$RepoUrl = "https://github.com/Harshads-git/production-ready-two-tier-devsecops-platform.git",
    [string]$GitName = "Harshads-git",
    [string]$GitEmail = "Harshads-git@users.noreply.github.com"
)

$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $ProjectRoot

if (-not (Test-Path -LiteralPath ".git")) {
    git init
}

git branch -M main
git config user.name $GitName
git config user.email $GitEmail

$remotes = git remote
if ($remotes -contains "origin") {
    git remote set-url origin $RepoUrl
} else {
    git remote add origin $RepoUrl
}

git add .
git commit -m "Day 1: initialize DevSecOps platform project"
git push -u origin main

Write-Host ""
Write-Host "Day 1 pushed to GitHub successfully."
