

foreach ($target in $targetsArray) {
 
# Define variables
$sourcePath = "$target.source"  # Change this to your source directory
$backupPath = "$target.storage"  # Change this to your backup directory
$maxBackups = $target.keep # Maximum number of backups to keep

# convert exclusion field to an array

$exclusionArray = @($target.exclude)

# Create a timestamp for the backup folder
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$backupFolder = Join-Path -Path $backupPath -ChildPath "Backup_$timestamp"

# Create the backup folder
New-Item -ItemType Directory -Path $backupFolder

# Copy files from source to backup folder
Copy-Item -Path "$sourcePath\*" -Destination $backupFolder -Recurse -Force -Exclude $exclusionArray

# Get a list of existing backup folders
$existingBackups = Get-ChildItem -Path $backupPath -Directory | Sort-Object LastWriteTime -Descending

# Check if the number of backups exceeds the maximum allowed
if ($existingBackups.Count -gt $maxBackups) {
    # Remove the oldest backups
    $backupsToRemove = $existingBackups[$maxBackups..($existingBackups.Count - 1)]
    foreach ($backup in $backupsToRemove) {
        Remove-Item -Path $backup.FullName -Recurse -Force
        Write-Host "Removed old backup: $($backup.FullName)"
    }
}

Write-Host "Backup completed successfully to: $backupFolder"


}