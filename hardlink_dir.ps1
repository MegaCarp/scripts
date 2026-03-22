param(
  [Parameter(Mandatory=$true)][string]$SourcePath,
  [Parameter(Mandatory=$true)][string]$DestinationPath,
  [switch]$Overwrite
)

$src = (Resolve-Path $SourcePath).ProviderPath
$dst = (Resolve-Path -LiteralPath $DestinationPath -ErrorAction SilentlyContinue)

if (-not $dst) { New-Item -ItemType Directory -Path $DestinationPath | Out-Null }
$dst = (Resolve-Path $DestinationPath).ProviderPath

if ([IO.Path]::GetPathRoot($src).ToLower() -ne [IO.Path]::GetPathRoot($dst).ToLower()) {
  Write-Error "Source and destination must be on the same volume for hard links."
  exit 1
}

Get-ChildItem -Path $src -File -Recurse | ForEach-Object {
  $relative = $_.FullName.Substring($src.Length).TrimStart('\','/')
  $targetDir = Join-Path $dst ([IO.Path]::GetDirectoryName($relative))
  if (-not (Test-Path $targetDir)) { New-Item -ItemType Directory -Path $targetDir | Out-Null }

  $linkPath = Join-Path $dst $relative
  if (Test-Path $linkPath) {
    if ($Overwrite) {
      Remove-Item -LiteralPath $linkPath -Force
    } else {
      Write-Host "Skipping existing: $linkPath"
      return
    }
  }

  $result = cmd /c "mklink /H `"$linkPath`" `"$($_.FullName)`""
  if ($LASTEXITCODE -ne 0) {
    Write-Warning "Failed to create hardlink for $($_.FullName)"
  } else {
    Write-Host "Linked: $linkPath"
  }
}
