#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe Gw2-64.exe") or WinActive("ahk_pid 10888")
Enter::Send "{Ctrl down}{Alt Down}{Shift down}={Ctrl up}{Alt up}{Shift up}"
F6::Send "{Enter}"