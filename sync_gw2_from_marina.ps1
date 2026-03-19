# Sync-GW2.ps1
$jobs = @(
    @{ Source = '\\DENIS-PC\Users\stash\SteamLibrary\steamapps\common\Guild Wars 2\addons'; Destination = 'C:\games\Guild Wars 2\Gw2Launcher\1\addons'; Log = 'C:\games\Guild Wars 2\Gw2Launcher\sync_addons.log' },
    @{ Source = '\\DENIS-PC\Users\stash\Documents\Guild Wars 2'; Destination = 'C:\Users\stash\AppData\Roaming\Gw2Launcher\data\1\Documents\Guild Wars 2'; Log = 'C:\games\Guild Wars 2\Gw2Launcher\sync_docs_KBDs.log' },
    @{ Source = '\\DENIS-PC\Users\stash\Documents\gw2\blishud\mbprofiles\blishhud.1'; Destination = 'C:\Users\stash\games\Blish HUD\mbprofiles\blishhud.1'; Log = 'C:\games\Guild Wars 2\Gw2Launcher\sync_blish.log' },
    @{ Source = '\\DENIS-PC\Users\stash\AppData\Roaming\Guild Wars 2'; Destination = 'C:\Users\stash\AppData\Roaming\Gw2Launcher\data\1\AppData\Roaming\Guild Wars 2'; Log = 'C:\games\Guild Wars 2\Gw2Launcher\sync_settings.log' }
)

# Ensure log directory exists
foreach ($j in $jobs)
{
    $logDir = Split-Path $j.Log -Parent
    if (-not (Test-Path $logDir))
    {
        New-Item -Path $logDir -ItemType Directory -Force | Out-Null 
    }
}

# Common robocopy args
$commonArgs = @('/MIR', '/Z', '/W:5', '/R:3', '/NP', '/NDL', '/NFL')

function Run-Robocopy ($src, $dst, $log)
{
    $time = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
    "$time - Starting robocopy: `"$src`" -> `"$dst`"" | Out-File -FilePath $log -Append -Encoding utf8
    $args = @($src, $dst) + $commonArgs + @("/LOG:`"$log`"")
    & robocopy @args
    $rc = $LASTEXITCODE
    $time = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
    "$time - Completed with exit code $rc`n" | Out-File -FilePath $log -Append -Encoding utf8
    return $rc
}

$overallExit = 0
foreach ($j in $jobs)
{
    try
    {
        $rc = Run-Robocopy -src $j.Source -dst $j.Destination -log $j.Log
        if ($rc -gt $overallExit)
        {
            $overallExit = $rc 
        }
    }
    catch
    {
        $msg = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - ERROR: $($_.Exception.Message)"
        $msg | Out-File -FilePath $j.Log -Append -Encoding utf8
        if ($overallExit -lt 1)
        {
            $overallExit = 1 
        }    
    }
}

exit $overallExit
