#Requires AutoHotkey v2.0
#Include ..\utils\base-sleep-interval.ahk

MouseGetPos &xpos, &ypos

Click
w8
Send "{Control down}c{Control up}"
w8
WinActivate("ahk_exe Gw2-64.exe")
w8
Click X := 598, Y := 240 ; click search bar
w8
Send "{Control down}"
w8
Send "a"
w8
Send "{Control up}"
Send A_Clipboard
Click X := 554, Y := 290
w8
Click
MouseMove xpos, ypos