# Define the path to the TSV file
$targetsData = "targets.txt"  # Change this to your actual file path

# Read the TSV file into an array
$targetsTable = Import-Csv -Path $targetsData -Delimiter "`t"

# a function for performing an instance of a backup that takes in an array from a vector of the target as an argument and outputs notification for completing the backup

foreach ($target in $targetsTable) {

    $exclusions = @($target.exclude) # convert exclusion field to an array

. .\func-backup-target.ps1
Backup-Target -targetName $target.name -sourcePath "$target.source" -backupPath "$target.storage" -exclusions $exclusions

$maxBackups = "$target.keep" # Maximum number of backups to keep


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

}