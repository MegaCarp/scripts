$backup_folder = Get-Content -Path backup.txt
$source = Get-Content -Path source.txt
$folder_name = Split-Path $source -Leaf


$currentDateTime = Get-Date -Format "yyyy-MM-dd-THH-mm-ss"

$pathResult = Join-Path $backup_folder -ChildPath $currentDateTime -AdditionalChildPath $folder_name

Copy-Item -Path $source -Destination $pathResult -Recurse 