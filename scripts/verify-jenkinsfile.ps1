$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $ProjectRoot

$Jenkinsfile = Join-Path $ProjectRoot "Jenkinsfile"

if (-not (Test-Path -LiteralPath $Jenkinsfile)) {
    throw "Jenkinsfile is missing."
}

$content = Get-Content -Raw -LiteralPath $Jenkinsfile

$requiredPatterns = @(
    "pipeline",
    "agent any",
    "stage('Preflight')",
    "stage('Python Tests')",
    "stage('Docker Build')",
    "stage('Secret Scan')",
    "stage('Vulnerability Scan')",
    "verify-ci.ps1",
    "verify-secrets.ps1",
    "trivy fs",
    "trivy image"
)

foreach ($pattern in $requiredPatterns) {
    if ($content -notlike "*$pattern*") {
        throw "Jenkinsfile validation failed. Missing expected pattern: $pattern"
    }
}

$openBraces = ([regex]::Matches($content, "\{")).Count
$closeBraces = ([regex]::Matches($content, "\}")).Count

if ($openBraces -ne $closeBraces) {
    throw "Jenkinsfile validation failed. Brace count mismatch."
}

Write-Host "Jenkinsfile structure verification completed successfully."

