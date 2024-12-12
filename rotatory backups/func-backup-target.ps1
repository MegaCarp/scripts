function Backup-Target {
    <#
    .SYNOPSIS
    This function takes a vector of fields that it then uses to backup from source to storage.
    It verifies the backup has been successful and uses hard links for incremental backups.
    #>
    param (
        [string]$targetName, # human readable name for the backup
        [string]$sourcePath,
        [string]$backupPath,
        [array]$exclusions
    )

    # Tests
    if (-not (Test-Path $sourcePath)) {
        Write-Error "$sourcePath does not exist"
        return
    }

    if (-not (Test-Path (Split-Path (Split-Path $backupPath)))) {
        Write-Error "Parent of the $backupPath does not exist"
        return
    }

    # Create a timestamp for the backup folder
    $timestamp = Get-Date -Format "yyyy-MM-dd-THH-mm-ss"
    $backupFolder = Join-Path -Path $backupPath -ChildPath "$targetName" -AdditionalChildPath "$timestamp"

    # Create the backup folder
    New-Item -ItemType Directory -Path $backupFolder -Force

    if (-not (Test-Path $backupFolder)) {
        Write-Error "Didn't create backup folder $backupFolder - exiting."
        return
    }

    # Get source files excluding the specified patterns
    $sourceFiles = Get-ChildItem -Path $sourcePath -Recurse -File | 
    Where-Object { 
        $exclude = $false
        foreach ($pattern in $exclusions) {
            if ($_.Name -like $pattern) {
                $exclude = $true
                break
            }
        }
        -not $exclude
    }

    # Get the last backup folder (if it exists)
    $lastBackupFolder = Get-ChildItem -Path $parentDirectory -Directory | 
    Sort-Object LastWriteTime -Descending | 
    Select-Object -First 1

    # Check if a folder was found and display the result
    if ($lastModifiedFolder) {
        Write-Host "The last modified folder is: $($lastModifiedFolder.FullName)"
        Write-Host "Last modified on: $($lastModifiedFolder.LastWriteTime)"
    }
    else {
        Write-Host "No folders found in the specified directory."
    }

    if (-not (Test-Path $lastBackupFolder)) {
        # If no last backup exists, copy all files
        Copy-Item -Path "$sourcePath\*" -Destination $backupFolder -Recurse -Force -Exclude $exclusions
    }
    else {
        # Perform incremental backup using hard links
        foreach ($sourceFile in $sourceFiles) {
            $relativePath = $sourceFile.FullName.Substring($sourcePath.Length + 1)
            $destFile = Join-Path -Path $backupFolder -ChildPath $relativePath
            $lastBackupFile = Join-Path -Path $lastBackupFolder -ChildPath $relativePath

            # Create the destination directory if it doesn't exist
            $destDir = Split-Path -Path $destFile -Parent
            if (-not (Test-Path $destDir)) {
                New-Item -ItemType Directory -Path $destDir -Force
            }

            if (Test-Path $lastBackupFile) {
                # If the file exists in the last backup, create a hard link
                New-Item -ItemType HardLink -Path $destFile -Target $lastBackupFile -Force
            }
            else {
                # If the file does not exist in the last backup, copy it
                Copy-Item -Path $sourceFile.FullName -Destination $destFile -Force
            }
        }
    }

    # Validate backup was successful
    $backupSuccessful = $true
    foreach ($sourceFile in $sourceFiles) {
        $relativePath = $sourceFile.FullName.Substring($sourcePath.Length + 1)
        $destFile = Join-Path -Path $backupFolder -ChildPath $relativePath

        if (-not (Test-Path -Path $destFile)) {
            Write-Host "Missing file in backup: $destFile"
            $backupSuccessful = $false
        }
        elseif ((Get-FileHash -Path $sourceFile.FullName).Hash -ne (Get-FileHash -Path $destFile).Hash) {
            Write-Host "File hash mismatch: $sourceFile.FullName"
            $backupSuccessful = $false
        }
    }

    if ($backupSuccessful) {
        Write-Host "Backup verification successful: All files are present and match."
        Write-Host "Backup completed successfully from: $sourcePath to: $backupFolder"
    }
    else {
        Write-Error "Backup verification failed: Some files are missing or do not match."
   
    }
}