function Backup-Target {

    <#
.SYNOPSIS
This function takes a vector of fields that it then uses to backup from source to storage.

It verifies the backup has been succesful.

It takes an array and breaks it down into arguments
#>
    param (
        [string]$targetName, # human readable name for the backup
        [string]$sourcePath,
        [string]$backupPath,
        [array]$exclusions
    )

    #tests

    if (Test-Path $sourcePath) 
    { <# Validate source exists #>
        Write-Output "$sourcePath exists"
    } 
    else {
        Write-Error "$sourcePath does not exist"
        return
    }

    if (Test-Path (Split-Path (Split-Path $backupPath))) 
    { <# Validate parent of the backup folder exists #>
        Write-Output "Parent of the $backupPath exists"
    } 
    else {
        Write-Error "Parent of the $backupPath does not exist"
        return
    }
    switch ($maxBackups.GetType().Name) {
        "Int32" { Write-Host "var maxBackups is an integer with value of `"$maxBackups`"" }
        "Double" { 
            Write-Host "var maxBackups is a double with value of `"$maxBackups`"" 
            $maxBackups = [math]::Ceiling($maxBackups)
            Write-Host "rounded it up to `"$maxBackups`"" 
        }
        Default {
            Write-Error "maxBackups invalid - it's not a number"
            return
        }
    }

    . .\lib\tests\validate-path-string-syntax.ps1
    foreach ($Path in $exclusions) {
        Test-PathString $Path #the function will test whether the path strings are valid and output a message into the log
    }

    # Create a timestamp for the backup folder in the format 01.12.24 24:59:59 being "2024-12-01-T24-59-59"
    $timestamp = Get-Date -Format "yyyy-MM-dd-THH-mm-ss"

    # concatenate path: backups folder, name of the backup and timestamp of the backup
    # if the backup is to be nameless, that's fine
    $backupFolder = Join-Path -Path $backupPath -ChildPath "$targetName" -AdditionalChildPath "$timestamp"

    # Create the backup folder
    New-Item -ItemType Directory -Path $backupFolder

    if (Test-Path $backupFolder) {
        Write-Output "Created backup folder $backupFolder succesfully"
        else {
            Write-Error "Didn't create backup folder $backupFolder - exiting."
            return
        }
    }

    # Copy files from source to backup folder
    Copy-Item -Path "$sourcePath\*" -Destination $backupFolder -Recurse -Force -Exclude $exclusions

    # validate backup was succesful

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

    # Get destination files
    $backedupFiles = Get-ChildItem -Path $backupFolder -Recurse -File

    # Compare the source and destination files
    $backupSuccessful = $true

    foreach ($sourceFile in $sourceFiles) {
        $relativePath = $sourceFile.FullName.Substring($sourcePath.Length + 1)
        $destFile = Join-Path -Path $backedupFiles -ChildPath $relativePath

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