#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe Gw2-64.exe") or WinActive("ahk_exe Blish\ HUD.exe")
Enter::Send "{Ctrl down}{Alt Down}{Shift down}={Ctrl up}{Alt up}{Shift up}"
F6::Send "{Enter}"