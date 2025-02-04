#Requires AutoHotkey v2.0

MouseGetPos &xpos, &ypos
Click X := 1901, Y := 456
Send "t"
Send "{Ctrl down}{Alt Down}{Shift down}={Ctrl up}{Alt up}{Shift up}"
Sleep 0 ; Adjust the delay as needed
Click X := 1043, Y := 698
Click X := 1032, Y := 735