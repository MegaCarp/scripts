(New-Object -ComObject WScript.Shell).AppActivate((get-process vmware-view).MainWindowTitle)
ps telegram | Stop-Process