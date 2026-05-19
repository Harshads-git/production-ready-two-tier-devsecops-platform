$ErrorActionPreference = "Stop"

function Invoke-Git {
    git @args
    if ($LASTEXITCODE -ne 0) {
        throw "Git command failed: git $args"
    }
}

$ProjectRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $ProjectRoot

Invoke-Git status
Invoke-Git add README.md app docs scripts tests

$hasChanges = git status --porcelain
if (-not $hasChanges) {
    Write-Host "No Day 2 changes to commit."
    exit 0
}

Invoke-Git commit -m "Day 2: add local app test workflow"
Invoke-Git push

Write-Host ""
Write-Host "Day 2 pushed to GitHub successfully."

