param(
    [Parameter(Mandatory=$true)][string]$SourceDir,
    [Parameter(Mandatory=$true)][string]$TargetDir,
    [Parameter(Mandatory=$true)][string]$DestinationDir,
    [switch]$PreserveTargetRelativePath  # if set, maintain target-relative path under DestinationDir
)

# Normalize paths
$SourceDir = (Resolve-Path -Path $SourceDir).ProviderPath
$TargetDir = (Resolve-Path -Path $TargetDir).ProviderPath
if (-not (Test-Path -Path $DestinationDir)) {
    New-Item -ItemType Directory -Path $DestinationDir -Force | Out-Null
}
$DestinationDir = (Resolve-Path -Path $DestinationDir).ProviderPath

# Get unique names from Source (files and directories)
$sourceItems = Get-ChildItem -Path $SourceDir -Recurse -Force -File:$true -Directory:$true -ErrorAction Stop
$names = $sourceItems | ForEach-Object { $_.Name } | Select-Object -Unique

foreach ($name in $names) {
    # Find matching items in Target (files and directories) by name, recursive
    $matches = Get-ChildItem -Path $TargetDir -Recurse -Force -File:$true -Directory:$true -ErrorAction SilentlyContinue |
               Where-Object { $_.Name -ieq $name }

    foreach ($m in $matches) {
        # Compute destination path
        if ($PreserveTargetRelativePath) {
            # keep path relative to TargetDir
            $relative = $m.FullName.Substring($TargetDir.Length).TrimStart('\','/')
            $destPath = Join-Path $DestinationDir $relative
            $destParent = Split-Path -Path $destPath -Parent
            if (-not (Test-Path -Path $destParent)) { New-Item -ItemType Directory -Path $destParent -Force | Out-Null }
        } else {
            $destPath = Join-Path $DestinationDir $m.Name
        }

        # If item is directory, move directory; if file, move file.
        if ($m.PSIsContainer) {
            # Avoid collision: if destination exists, add suffix
            $finalPath = $destPath
            $counter = 1
            while (Test-Path -Path $finalPath) {
                $finalPath = "${destPath}_$counter"
                $counter++
            }
            Write-Output "Moving directory:`n  From: $($m.FullName)`n  To:   $finalPath"
            Move-Item -Path $m.FullName -Destination $finalPath -Force
        } else {
            # File
            $finalPath = $destPath
            if (Test-Path -Path $finalPath) {
                # create unique name before moving
                $base = [System.IO.Path]::GetFileNameWithoutExtension($destPath)
                $ext  = [System.IO.Path]::GetExtension($destPath)
                $dir  = Split-Path -Path $destPath -Parent
                $counter = 1
                do {
                    $finalPath = Join-Path $dir ("{0}_{1}{2}" -f $base, $counter, $ext)
                    $counter++
                } while (Test-Path -Path $finalPath)
            } else {
                $parent = Split-Path -Path $finalPath -Parent
                if (-not (Test-Path -Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
            }
            Write-Output "Moving file:`n  From: $($m.FullName)`n  To:   $finalPath"
            Move-Item -Path $m.FullName -Destination $finalPath -Force
        }
    }
}
