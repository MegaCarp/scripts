#Requires AutoHotkey v2.0

MouseGetPos &xpos, &ypos
LastWindow := WinGetTitle("A")
WinActivate "DNP"
MouseMove 363, 1025 ; здесь у меня расположен Google Chrome
Sleep 500
Click 368, 956 ; не свернув, активировать хром
Click 158, 92 ; здесь первая вкладка Chrome
Sleep 200
WinActivate LastWindow
MouseMove xpos, ypos