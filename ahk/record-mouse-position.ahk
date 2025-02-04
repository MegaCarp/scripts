#Requires AutoHotkey v2.0
#Include utils\base-sleep-interval.ahk

MouseGetPos &xpos, &ypos
A_Clipboard := "`n" "Click X := " xpos ", Y := " ypos "`n" "w8"
w8
WinActivate "Visual Studio Code"
w8
Send "{End}"
w8
Send A_Clipboard
w8
Send "^{Left}^{Left}^{Right}{Space};{Space}"