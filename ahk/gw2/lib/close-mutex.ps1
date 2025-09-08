# close-mutex.ps1
param(
    [string]$handlePath = 'C:\Users\stash\bin\handle\handle.exe',
    [string]$mutexName  = 'AN-Mutex-Window-Guild Wars 2',
    [string]$logPath    = 'C:\Temp\close-handle-log.txt'
)

# Elevate if not running as admin
function Ensure-Elevated {
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        $psi = New-Object System.Diagnostics.ProcessStartInfo
        $psi.FileName = pwsh.exe
        $psi.Arguments = "-NoProfile -NoLogo -ExecutionPolicy Bypass -File `"$PSCommandPath`" -handlePath `"$handlePath`" -mutexName `"$mutexName`" -logPath `"$logPath`""
        $psi.Verb = 'runas'
        try {
            [System.Diagnostics.Process]::Start($psi) | Out-Null
        } catch {
            Write-Error 'Elevation canceled or failed.'
        }
        exit
    }
}

Ensure-Elevated

# Ensure output directory exists
New-Item -ItemType Directory -Path (Split-Path $logPath) -Force | Out-Null

# Run handle and capture output (stderr merged)
$raw = & $handlePath -accepteula -a $mutexName 2>&1

if (-not $raw -or ($raw -join "`n") -match 'No matching handles found') {
    Write-Output "No matching handles found for '$mutexName'."
    Set-Content -Path $logPath -Value "No matching handles found for '$mutexName'`n$(Get-Date -Format o)" -Encoding UTF8
    exit 0
}

# Example handle.exe line formats vary. Use regex to extract PID and handle token.
# This pattern tries to capture "pid: <digits>" and a hex handle token later on the line.
$pattern1 = [regex]'\bpid:\s*(\d+)\b.*?([0-9A-Fa-f]{1,16})\b$'
$pattern2 = [regex]'\bpid:\s*(\d+)\b.*?([0-9A-Fa-f]{1,16}):([0-9A-Fa-f]{1,16})\b'
# fallback: any PID and last hex token on line
$patternPid = [regex]'\bpid:\s*(\d+)\b'
$hexFind = [regex]'[0-9A-Fa-f]{1,16}'

$commands = [System.Collections.Generic.List[string]]::new()
$logLines = [System.Collections.Generic.List[string]]::new()
$logLines.Add("Run at: $(Get-Date -Format o)")
$logLines.Add("Searching for mutex: $mutexName")
$logLines.Add("handle.exe path: $handlePath")
$logLines.Add('')

foreach ($line in $raw) {
    if ($line.Trim().Length -eq 0) { continue }

    $targetPID = $null
    $handleToken = $null

    $m2 = $pattern2.Match($line)
    if ($m2.Success) {
        $targetPID = $m2.Groups[1].Value
        # group 3 often contains the handle token in "XXXX:YYYY" format, prefer that
        $handleToken = $m2.Groups[3].Value
    } else {
        $m1 = $pattern1.Match($line)
        if ($m1.Success) {
            $targetPID = $m1.Groups[1].Value
            $handleToken = $m1.Groups[2].Value
        } else {
            $mp = $patternPid.Match($line)
            if ($mp.Success) {
                $targetPID = $mp.Groups[1].Value
                $hexes = $hexFind.Matches($line) | ForEach-Object { $_.Value }
                if ($hexes.Count -gt 0) {
                    $handleToken = $hexes[-1]
                }
            }
        }
    }

    if ($targetPID -and $handleToken) {
        $cmd = "& `"$handlePath`" -accepteula -c $handleToken -y -p $targetPID"
        $commands.Add($cmd)
        $logLines.Add("Found: PID=$targetPID Handle=$handleToken")
    } else {
        $logLines.Add("Unparsed line: $line")
    }
}

if ($commands.Count -eq 0) {
    $logLines.Add('No valid handle close commands constructed. Aborting.')
    $logLines | Set-Content -Path $logPath -Encoding UTF8
    Write-Output 'No valid handle close commands found.'
    exit 1
}

# Write log of what we will do
$logLines.Add('')
$logLines.Add('Commands to run:')
$commands | ForEach-Object { $logLines.Add("  $_") }
$logLines | Set-Content -Path $logPath -Encoding UTF8

# Confirm and run
Write-Output "About to run $($commands.Count) handle.exe close commands. See log: $logPath"
foreach ($c in $commands) {
    Write-Output $c
    # Execute the command string using PowerShell's call operator parsing
    Invoke-Expression $c
    Start-Sleep -Milliseconds 200
}

Write-Output 'Done.'
$logLines.Add("Completed at: $(Get-Date -Format o)")
$logLines | Set-Content -Path $logPath -Encoding UTF8
