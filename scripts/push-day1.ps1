param(
    [string]$RepoUrl = "https://github.com/Harshads-git/production-ready-two-tier-devsecops-platform.git",
    [string]$GitName = "Harshads-git",
    [string]$GitEmail = "Harshads-git@users.noreply.github.com"
)

$ErrorActionPreference = "Stop"

function Invoke-Git {
    git @args
    if ($LASTEXITCODE -ne 0) {
        throw "Git command failed: git $args"
    }
}

$ProjectRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $ProjectRoot

if (-not (Test-Path -LiteralPath ".git")) {
    Invoke-Git init
}

Invoke-Git branch -M main
Invoke-Git config user.name $GitName
Invoke-Git config user.email $GitEmail

$remotes = git remote
if ($remotes -contains "origin") {
    Invoke-Git remote set-url origin $RepoUrl
} else {
    Invoke-Git remote add origin $RepoUrl
}

Invoke-Git add .

$hasChanges = git status --porcelain
if ($hasChanges) {
    git rev-parse --verify HEAD *> $null
    if ($LASTEXITCODE -eq 0) {
        Invoke-Git commit -m "Fix Day 1 GitHub push helper"
    } else {
        Invoke-Git commit -m "Day 1: initialize DevSecOps platform project"
    }
} else {
    Write-Host "No new local changes to commit."
}

Invoke-Git fetch origin main

$remoteMain = git rev-parse --verify origin/main 2>$null
if ($LASTEXITCODE -eq 0) {
    Invoke-Git pull --rebase origin main --allow-unrelated-histories
}

Invoke-Git push -u origin main

Write-Host ""
Write-Host "Day 1 pushed to GitHub successfully."
