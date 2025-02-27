#Requires AutoHotkey v2.0

MouseGetPos &xpos, &ypos
LastWindow := WinGetID("A")
WinActivate "DNP"
MouseMove 363, 1025 ; здесь у меня расположен Google Chrome
Sleep 500
Click 368, 956 ; не свернув, активировать хром
Click 158, 92 ; здесь первая вкладка Chrome
Sleep 200
WinActivate LastWindow
MouseMove xpos, ypos
if WinActive("ahk_exe Gw2-64.exe") != 0 {
    Sleep 100
    Send "e"
    Send "e"
    Send "e"
}

; msgbox WinGetTitle("A")
