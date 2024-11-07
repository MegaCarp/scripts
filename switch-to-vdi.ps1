(New-Object -ComObject WScript.Shell).AppActivate((get-process vmware-view).MainWindowTitle)
Get-Process telegram | Stop-Process