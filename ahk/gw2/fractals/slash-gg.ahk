#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe Gw2-64.exe")

Send "{Enter}"
w8(standardWaitTime + 100)
Send "/gg"
w8(standardWaitTime + 100)
Send "{Enter}"
MouseMove X := 991, Y := 551