param(
    [Parameter(Mandatory = $true)]
    [string]$Day,

    [Parameter(Mandatory = $true)]
    [string]$TechnicalMessage,

    [Parameter(Mandatory = $true)]
    [string]$VerificationMessage,

    [Parameter(Mandatory = $true)]
    [string]$EvidenceMessage
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

$GitEmail = "183264980+Harshads-git@users.noreply.github.com"

Invoke-Git config user.name "Harshads-git"
Invoke-Git config user.email $GitEmail

Write-Host "Using Git email:"
git config user.email
Write-Host ""

Write-Host "Current status:"
git status --short
Write-Host ""

$technicalFiles = @(
    ".dockerignore",
    ".env.example",
    "Dockerfile",
    "docker-compose.yml",
    "app"
)

$verificationFiles = @(
    "tests",
    "scripts",
    ".github",
    ".trivyignore"
    "Jenkinsfile"
)

$evidenceFiles = @(
    "README.md",
    "docs",
    "docker",
    "diagrams"
)

Invoke-Git add -- $technicalFiles
$technicalChanges = git diff --cached --name-only

if ($technicalChanges) {
    Invoke-Git commit -m "$Day`: $TechnicalMessage"
} else {
    Write-Host "No technical changes staged."
}

Invoke-Git add -- $verificationFiles
$verificationChanges = git diff --cached --name-only

if ($verificationChanges) {
    Invoke-Git commit -m "$Day`: $VerificationMessage"
} else {
    Write-Host "No verification changes staged."
}

Invoke-Git add -- $evidenceFiles
$evidenceChanges = git diff --cached --name-only

if ($evidenceChanges) {
    Invoke-Git commit -m "$Day`: $EvidenceMessage"
} else {
    Write-Host "No evidence changes staged."
}

Invoke-Git push

Write-Host ""
Write-Host "Latest commits:"
git log -3 --format="%h %ad %ae %s" --date=short

Write-Host ""
Write-Host "Final status:"
git status
