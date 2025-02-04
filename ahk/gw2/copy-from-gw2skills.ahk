#Requires AutoHotkey v2.0
#Include ..\utils\base-sleep-interval.ahk

Click
w8
Send "{Control}c"
w8
WinActivate("ahk_exe Gw2-64.exe")
Send "^a"
w8
Send A_Clipboard
Click X := 554, Y := 290
w8
Click