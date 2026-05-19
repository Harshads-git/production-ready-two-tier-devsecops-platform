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

function Get-PythonCommand {
    $candidates = @("python", "py")

    foreach ($candidate in $candidates) {
        if (Get-Command $candidate -ErrorAction SilentlyContinue) {
            $previousErrorActionPreference = $ErrorActionPreference
            try {
                $ErrorActionPreference = "Continue"
                & $candidate --version *> $null
                if ($LASTEXITCODE -eq 0) {
                    return $candidate
                }
            } catch {
            } finally {
                $ErrorActionPreference = $previousErrorActionPreference
            }
        }
    }

    throw "Python is not available. Install Python from python.org and enable 'Add python.exe to PATH'."
}

$Python = Get-PythonCommand

if (-not (Test-Path -LiteralPath ".venv")) {
    Invoke-Checked $Python -m venv .venv
}

& ".\.venv\Scripts\Activate.ps1"
Invoke-Checked pip install -r app\requirements.txt
& $Python app\app.py
