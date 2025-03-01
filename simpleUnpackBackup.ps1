
Stop-Process soff* -Force
$TargetPath = "C:\Users\d.stashko\personal\LibreOffice"
$PrimaryBackupPath = "C:\Users\d.stashko\personal\LibreOffice"
$BackupStoragePath = "C:\Users\d.stashko\personal\bak"

if (Test-Path $TargetPath) {

    $tmpBackupPath = $TargetPath + ".bak"

    if (Test-Path $tmpBackupPath) {

        $timestamp = Get-Date -Format "yy.MM.dd-HH.mm"
        $timestampedName = $tmpBackupPath + $timestamp

        Rename-Item $tmpBackupPath $timestampedName

    }

    Rename-Item $TargetPath $tmpBackupPath

}

Copy-Item $PrimaryBackupPath $TargetPath
