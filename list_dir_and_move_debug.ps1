# Run example (no changes done):
# pwsh ./Move-MatchingItems_Debug.ps1 -SourceDir "C:\Source" -TargetDir "C:\Target" -DestinationDir "C:\Dest"

# To actually perform moves add -DoMove:
# pwsh ./Move-MatchingItems_Debug.ps1 -SourceDir "C:\Source" -TargetDir "C:\Target" -DestinationDir "C:\Dest" -DoMove

# If you run it and paste the top ~20 lines of output here I’ll diagnose why nothing moved.`

param(
  [Parameter(Mandatory=$true)][string]$SourceDir,
  [Parameter(Mandatory=$true)][string]$TargetDir,
  [Parameter(Mandatory=$true)][string]$DestinationDir,
  [switch]$PreserveTargetRelativePath,
  [switch]$DoMove  # set to actually perform the move
)

function ResolveDir($p){
  try { (Resolve-Path -Path $p).ProviderPath } catch { throw "Path not found: $p" }
}

$SourceDir = ResolveDir $SourceDir
$TargetDir = ResolveDir $TargetDir
if (-not (Test-Path $DestinationDir)) { New-Item -ItemType Directory -Path $DestinationDir -Force | Out-Null }
$DestinationDir = ResolveDir $DestinationDir

Write-Output "Source: $SourceDir"
Write-Output "Target: $TargetDir"
Write-Output "Destination: $DestinationDir"
Write-Output "PreserveTargetRelativePath: $PreserveTargetRelativePath"
Write-Output "DoMove: $DoMove"

# get all names in source (files and directories)
$sourceItems = Get-ChildItem -Path $SourceDir -Recurse -Force -ErrorAction Stop
$names = $sourceItems | ForEach-Object { $_.Name } | Sort-Object -Unique
Write-Output "Found $($names.Count) unique names in source."

foreach ($name in $names) {
  Write-Output "`nChecking name: $name"
  $matches = Get-ChildItem -Path $TargetDir -Recurse -Force -ErrorAction SilentlyContinue |
             Where-Object { $_.Name -ieq $name }

  if (-not $matches) {
    Write-Output "  No matches in target."
    continue
  }

  Write-Output "  Found $($matches.Count) match(es) in target."
  foreach ($m in $matches) {
    Write-Output "    Match: $($m.FullName)  (IsDirectory: $($m.PSIsContainer))"

    if ($PreserveTargetRelativePath) {
      $relative = $m.FullName.Substring($TargetDir.Length).TrimStart('\','/')
      $destPath = Join-Path $DestinationDir $relative
      $destParent = Split-Path -Path $destPath -Parent
      if (-not (Test-Path $destParent)) { New-Item -ItemType Directory -Path $destParent -Force | Out-Null }
    } else {
      $destPath = Join-Path $DestinationDir $m.Name
    }

    # avoid collisions
    if ($m.PSIsContainer) {
      $finalPath = $destPath
      $i = 1
      while (Test-Path $finalPath) { $finalPath = "${destPath}_$i"; $i++ }
      Write-Output "    Moving directory to: $finalPath"
      if ($DoMove) { Move-Item -Path $m.FullName -Destination $finalPath -Force } else { Write-Output "    (WhatIf) Move-Item $($m.FullName) -> $finalPath" }
    } else {
      $finalPath = $destPath
      if (Test-Path $finalPath) {
        $base = [System.IO.Path]::GetFileNameWithoutExtension($destPath)
        $ext  = [System.IO.Path]::GetExtension($destPath)
        $dir  = Split-Path -Path $destPath -Parent
        $i = 1
        do { $finalPath = Join-Path $dir ("{0}_{1}{2}" -f $base, $i, $ext); $i++ } while (Test-Path $finalPath)
      } else {
        $parent = Split-Path -Path $finalPath -Parent
        if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
      }
      Write-Output "    Moving file to: $finalPath"
      if ($DoMove) { Move-Item -Path $m.FullName -Destination $finalPath -Force } else { Write-Output "    (WhatIf) Move-Item $($m.FullName) -> $finalPath" }
    }
  }
}
