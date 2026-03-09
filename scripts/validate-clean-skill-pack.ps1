param(
    [string]$RepoRoot = (Split-Path -Path $PSScriptRoot -Parent),
    [string]$PythonCommand = "python",
    [string]$ValidatorPath = "$env:USERPROFILE\.codex\skills\.system\skill-creator\scripts\quick_validate.py",
    [switch]$SkipQuickValidate,
    [switch]$SkipAgentChecks,
    [switch]$SkipAssetChecks
)

$ErrorActionPreference = "Stop"

function Add-Failure {
    param(
        [System.Collections.Generic.List[string]]$Failures,
        [string]$Message
    )

    $Failures.Add($Message) | Out-Null
}

function Test-RequiredFile {
    param(
        [string]$Path,
        [System.Collections.Generic.List[string]]$Failures,
        [string]$Label
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        Add-Failure -Failures $Failures -Message ("missing {0}: {1}" -f $Label, $Path)
    }
}

function Invoke-QuickValidate {
    param(
        [string]$PythonCommand,
        [string]$ValidatorPath,
        [string]$SkillPath
    )

    $oldUtf8 = $env:PYTHONUTF8
    $env:PYTHONUTF8 = "1"

    try {
        $output = & $PythonCommand $ValidatorPath $SkillPath 2>&1
        $exitCode = $LASTEXITCODE
        return @{
            ExitCode = $exitCode
            Output = ($output -join [Environment]::NewLine)
        }
    }
    finally {
        $env:PYTHONUTF8 = $oldUtf8
    }
}

function Test-Skill {
    param(
        [System.IO.DirectoryInfo]$SkillDir,
        [string]$PythonCommand,
        [string]$ValidatorPath,
        [bool]$RunQuickValidate,
        [bool]$RunAgentChecks,
        [bool]$RunAssetChecks
    )

    $failures = New-Object "System.Collections.Generic.List[string]"
    $skillPath = $SkillDir.FullName
    $skillFile = Join-Path $skillPath "SKILL.md"

    Test-RequiredFile -Path $skillFile -Failures $failures -Label "SKILL.md"

    if ($RunAgentChecks) {
        Test-RequiredFile -Path (Join-Path $skillPath "agents\openai.yaml") -Failures $failures -Label "agents/openai.yaml"
    }

    if ($RunAssetChecks) {
        $assetFiles = @(
            "assets\icon.svg",
            "assets\logo.svg",
            "assets\icon.png",
            "assets\logo.png"
        )

        foreach ($assetFile in $assetFiles) {
            Test-RequiredFile -Path (Join-Path $skillPath $assetFile) -Failures $failures -Label $assetFile
        }
    }

    $validateResult = $null
    if ($RunQuickValidate) {
        if (-not (Test-Path -LiteralPath $ValidatorPath -PathType Leaf)) {
            Add-Failure -Failures $failures -Message "missing validator script: $ValidatorPath"
        }
        elseif ($failures.Count -eq 0) {
            $validateResult = Invoke-QuickValidate -PythonCommand $PythonCommand -ValidatorPath $ValidatorPath -SkillPath $skillPath
            if ($validateResult.ExitCode -ne 0) {
                Add-Failure -Failures $failures -Message "quick_validate failed: $($validateResult.Output)"
            }
        }
    }

    return [pscustomobject]@{
        Skill = $SkillDir.Name
        Path = $skillPath
        Success = ($failures.Count -eq 0)
        Failures = @($failures)
        QuickValidateOutput = if ($validateResult) { $validateResult.Output } else { $null }
    }
}

$skillsRoot = Join-Path $RepoRoot "skills"
if (-not (Test-Path -LiteralPath $skillsRoot -PathType Container)) {
    Write-Error "Skills directory not found: $skillsRoot"
}

$skillDirs = Get-ChildItem -LiteralPath $skillsRoot -Directory | Sort-Object Name
if (-not $skillDirs) {
    Write-Error "No skills found under: $skillsRoot"
}

$runQuickValidate = -not $SkipQuickValidate
$runAgentChecks = -not $SkipAgentChecks
$runAssetChecks = -not $SkipAssetChecks

$results = foreach ($skillDir in $skillDirs) {
    Test-Skill `
        -SkillDir $skillDir `
        -PythonCommand $PythonCommand `
        -ValidatorPath $ValidatorPath `
        -RunQuickValidate:$runQuickValidate `
        -RunAgentChecks:$runAgentChecks `
        -RunAssetChecks:$runAssetChecks
}

$passed = @($results | Where-Object { $_.Success })
$failed = @($results | Where-Object { -not $_.Success })

Write-Host "Clean skill pack validation" -ForegroundColor Cyan
Write-Host "Repo root: $RepoRoot"
Write-Host "Skills checked: $($results.Count)"
Write-Host ""

foreach ($result in $results) {
    if ($result.Success) {
        Write-Host "[PASS] $($result.Skill)" -ForegroundColor Green
    }
    else {
        Write-Host "[FAIL] $($result.Skill)" -ForegroundColor Red
        foreach ($failure in $result.Failures) {
            Write-Host "  - $failure" -ForegroundColor Red
        }
    }
}

Write-Host ""
Write-Host "Summary: $($passed.Count) passed, $($failed.Count) failed." -ForegroundColor Yellow

if ($failed.Count -gt 0) {
    exit 1
}

exit 0
