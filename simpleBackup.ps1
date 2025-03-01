
Stop-Process soff* -Force
$TargetPath = "C:\Users\d.stashko\personal\LibreOffice"
$PrimaryBackupPath = "C:\Users\d.stashko\personal\LibreOffice"
$BackupStoragePath = "C:\Users\d.stashko\personal\bak\LibreOffice"

if (Test-Path $PrimaryBackupPath) {

    $timestamp = Get-Date -Format "yy.MM.dd-HH.mm"
    $timestampedName = $BackupStoragePath + $timestamp

    Move-Item $PrimaryBackupPath $timestampedName

}

Copy-Item $TargetPath $PrimaryBackupPath