# Sync-GW2_fixed.ps1
$jobs = @(
    @{ Source = '\\DENIS-PC\Steam\steamapps\common\GuildWars2\addons'; Destination = 'C:\games\Guild Wars 2\Gw2Launcher\1\addons'; Log = 'C:\games\Guild Wars 2\Gw2Launcher\sync_addons.log' },
    @{ Source = '\\DENIS-PC\Steam\steamapps\common\GuildWars2\d3d11.dll'; Destination = 'C:\games\Guild Wars 2\Gw2Launcher\1\d3d11.dll"'; Log = 'C:\games\Guild Wars 2\Gw2Launcher\sync-nexus.log' },
    @{ Source = '\\DENIS-PC\Users\stash\AppData\Roaming\Gw2Launcher\data\1\Documents\Guild Wars 2'; Destination = 'C:\Users\stash\AppData\Roaming\Gw2Launcher\data\1\Documents\Guild Wars 2'; Log = 'C:\games\Guild Wars 2\Gw2Launcher\sync_docs_KBDs.log' },
    @{ Source = '\\DENIS-PC\Users\stash\Documents\gw2\blishud\mbprofiles\blishhud.1'; Destination = 'C:\Users\stash\games\Blish HUD\mbprofiles\blishhud.1'; Log = 'C:\games\Guild Wars 2\Gw2Launcher\sync_blish.log' },
    @{ Source = '\\DENIS-PC\Users\stash\AppData\Roaming\Guild Wars 2'; Destination = 'C:\Users\stash\AppData\Roaming\Gw2Launcher\data\1\AppData\Roaming\Guild Wars 2'; Log = 'C:\games\Guild Wars 2\Gw2Launcher\sync_settings.log' }
)

# Ensure log directories exist
foreach ($j in $jobs) {
    $logDir = Split-Path $j.Log -Parent
    if (-not (Test-Path $logDir)) { New-Item -Path $logDir -ItemType Directory -Force | Out-Null }
}

$commonArgs = @('/MIR','/Z','/W:5','/R:3','/NP','/NDL','/NFL')

function Run-Robocopy {
    param($src, $dst, $log)

    if (-not (Test-Path $src)) {
        "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - ERROR: Source not found: $src" | Out-File -FilePath $log -Append -Encoding utf8
        return 8
    }
    $dstParent = Split-Path -Path $dst -Parent
    if (-not (Test-Path $dstParent)) { New-Item -Path $dstParent -ItemType Directory -Force | Out-Null }

    $time = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
    "$time - Starting robocopy: `"$src`" -> `"$dst`"" | Out-File -FilePath $log -Append -Encoding utf8

    # Build a single properly quoted argument string
    $allArgs = @()
    $allArgs += '"' + $src + '"'
    $allArgs += '"' + $dst + '"'
    foreach ($a in $commonArgs) { $allArgs += $a }
    $allArgs += '/LOG:"' + $log + '"'

    $argString = $allArgs -join ' '

    $proc = Start-Process -FilePath 'robocopy' -ArgumentList $argString -NoNewWindow -Wait -PassThru
    $rc = $proc.ExitCode

    $time = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
    "$time - Completed with exit code $rc" | Out-File -FilePath $log -Append -Encoding utf8

    return $rc
}

function Is-RoboSuccess([int]$rc) {
    # Robocopy uses bitmask exit codes. 0-7 are success/warnings. 8+ indicate failure.
    return ($rc -lt 8)
}

$overallExit = 0

foreach ($j in $jobs) {
    try {
        $rc = Run-Robocopy -src $j.Source -dst $j.Destination -log $j.Log
        if (-not (Is-RoboSuccess $rc)) {
            # treat fatal robocopy exit as at least 8
            if ($overallExit -lt $rc) { $overallExit = $rc }
        } elseif ($rc -gt $overallExit) {
            # non-fatal codes (0-7) still may be higher; keep max but <8
            $overallExit = $rc
        }
    } catch {
        "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - ERROR: $($_.Exception.Message)" | Out-File -FilePath $j.Log -Append -Encoding utf8
        if ($overallExit -lt 1) { $overallExit = 1 }
    }
}

# normalize exit code: return 0 for success, 1 for any failure
if ($overallExit -lt 8) {
    exit 0
} else {
    exit 1
}
