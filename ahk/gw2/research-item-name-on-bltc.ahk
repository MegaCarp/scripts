#Requires AutoHotkey v2.0
#Include ..\utils\defaults-global.ahk

Click , , , 3
Send "^c"
WinActivate "Excel"
WinActivate "GW2BLTC"
Click X := 1356, Y := 137 ; search window
w8
Send A_Clipboard
; Send "Diviner's Draconic Helm"
w8
Send "{Enter}"
w8(2000)

Click X := 519, Y := 363 ; click on the first item found
w8(1000)

Click X := 1807, Y := 355 ; click on free space before rolling the window down
Send "{PgDn}"
w8
Send "{PgDn}"
w8(500)
Send "{PgDn}"
w8
Send "{PgDn}"
w8
w8(300)
Click X := 597, Y := 343 ; click on "week" in graph