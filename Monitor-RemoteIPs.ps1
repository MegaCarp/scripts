# Below is a ready-to-run PowerShell script that satisfies your requirements:
# - No hardcoded single PID — accepts process names or PIDs.
# - Supports multiple processes (wildcard process-name matching and explicit PIDs).
# - Uses a foreach loop over resolved PIDs.
# - Polls Get-NetTCPConnection, deduplicates remote IPs, and writes a live comma-separated string to console and file.
# - Runs continuously with configurable interval.

# Save as Monitor-RemoteIPs.ps1 and run as Administrator.

# Usage examples:
# - Run with defaults (matches chrome* and msedge*): .\Monitor-RemoteIPs.ps1
# - Specify names and extra PIDs: .\Monitor-RemoteIPs.ps1 -ProcessNames "myApp","otherApp*" -ExtraPids 1234,5678 -IntervalSec 10 -OutFile "C:\temp\ips.csv"

# Notes:
# - Run PowerShell as Administrator for reliable Get-NetTCPConnection output.
# - This only monitors TCP Established connections; transient or UDP traffic will not appear.
# - The script appends discovered IPs into a set (deduped). If you want periodic resets, change how $seen is managed (e.g., clear it on a timer).

param(
  [string[]] $ProcessNames = @('gw*', '*cef*'),  # wildcard names you want to include
  [int[]]    $ExtraPids = @(),                   # explicit PIDs to include
  [int]      $IntervalSec = 5,
  [string]   $OutFile = 'C:\Temp\app_remote_ips.csv',
  [switch]  $Once = $false,
  [switch]  $VerboseDiagnostics = $false,
  [switch]  $RunTests = $false

)

if ($RunTests)
{
  'Running tests...'
  $gwpids = Test-Resolve -names $ProcessNames -extras $ExtraPids
  if ($gwpids.Count -eq 0)
  {
    'Test Resolve: no processes found; ensure your patterns match running processes.' 
  }
  Test-GetConns -pids $gwpids
  Test-EndToEnd -names $ProcessNames -extras $ExtraPids
  exit 0
}


# Ensure output folder exists
$dir = Split-Path $OutFile -Parent
if (-not (Test-Path $dir))
{
  New-Item -ItemType Directory -Path $dir -Force | Out-Null 
}

function Test-Resolve
{
  param([string[]] $names, [int[]] $extras)
  $gwpids = Resolve-Pids -names $names -extras $extras
  "Resolved PIDs: $($gwpids -join ', ')"
  return $gwpids
}

function Test-GetConns
{
  param([int[]] $gwpids)
  foreach ($gwpid in $gwpids)
  {
    try
    {
      $conns = Get-NetTCPConnection -OwningProcess $gwpid -State Established -ErrorAction SilentlyContinue
      $count = if ($conns)
      {
        ($conns | Measure-Object).Count 
      }
      else
      {
        0 
      }
      "PID ${gwpid}: Established connections = $count"
      if ($conns)
      {
        $conns | Select-Object -First 5 RemoteAddress, RemotePort | ForEach-Object { "  $_" } 
      }
    }
    catch
    {
      "PID ${gwpid}: error retrieving connections"
    }
  }
}

function Test-EndToEnd
{
  param([string[]] $names, [int[]] $extras)
  $gwpids = Resolve-Pids -names $names -extras $extras
  $seenTest = [System.Collections.Generic.HashSet[string]]::new()
  foreach ($gwpid in $gwpids)
  {
    $conns = Get-NetTCPConnection -OwningProcess $gwpid -State Established -ErrorAction SilentlyContinue
    if ($conns)
    {
      $conns | Select-Object -ExpandProperty RemoteAddress | Where-Object { $_ -and $_ -notin @('0.0.0.0', '::') } | ForEach-Object { $null = $seenTest.Add($_) } 
    }
  }
  $csvTest = ($seenTest | Sort-Object) -join ', '
  "Test CSV (single-iteration): $csvTest"
  return $csvTest
}


# Resolve process names (wildcards) to PIDs
function Resolve-Pids
{
  param([string[]] $names, [int[]] $extras)
  $gwpids = [System.Collections.Generic.HashSet[int]]::new()
  foreach ($name in $names)
  {
    try
    {
      Get-Process -Name $name -ErrorAction SilentlyContinue | ForEach-Object { $gwpids.Add($_.Id) | Out-Null }
    }
    catch
    { 
    }
  }
  foreach ($gwpid in $extras)
  {
    $gwpids.Add([int]$gwpid) | Out-Null 
  }
  return $gwpids
}

# Normalize/validate IP string (exclude unspecified addresses)
function IsValidIp
{
  param([string] $ip)
  if ([string]::IsNullOrWhiteSpace($ip))
  {
    return $false 
  }
  if ($ip -in @('0.0.0.0', '::'))
  {
    return $false 
  }
  return $true
}

# Main loop
$seen = [System.Collections.Generic.HashSet[string]]::new()

do {
    $gwpids = Resolve-Pids -names $ProcessNames -extras $ExtraPids

    if ($VerboseDiagnostics) { Write-Output "PIDs: $($gwpids -join ', ')" }

    if ($gwpids.Count -eq 0) {
        Write-Output "$(Get-Date -Format u) - No matching processes found."
    } else {
        foreach ($gwpid in $gwpids) {
            try {
                $conns = Get-NetTCPConnection -OwningProcess $gwpid -State Established -ErrorAction SilentlyContinue
                $count = if ($conns) { ($conns | Measure-Object).Count } else { 0 }
                if ($VerboseDiagnostics) { Write-Output "PID $gwpid connections: $count" }
                if ($conns) {
                    $conns | Select-Object -ExpandProperty RemoteAddress | ForEach-Object {
                        if (IsValidIp $_) { $null = $seen.Add($_) }
                    }
                }
            } catch { }
        }

        $csv = ($seen | Sort-Object) -join ', '
        Write-Output $csv
        $csv | Out-File -FilePath $OutFile -Encoding utf8
    }

    if ($Once) { break }
    Start-Sleep -Seconds $IntervalSec
} while ($true)


