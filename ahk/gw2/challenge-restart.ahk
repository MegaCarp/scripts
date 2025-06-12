#Requires AutoHotkey v2.0
#SingleInstance Force

MouseGetPos &xpos, &ypos
Send "{r down}"
; Send "{Ctrl down}{Alt Down}{Shift down}[{Ctrl up}{Alt up}{Shift up}"
Click X := 1901, Y := 456
Send "t"
Sleep 0 ; Adjust the delay as needed
Click X := 1043, Y := 698
Click X := 1032, Y := 735
Send "{r up}"
