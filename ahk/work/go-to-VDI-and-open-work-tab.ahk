#Requires AutoHotkey v2.0

; WinActivate "ahk_exe Telegram.exe"
; Sleep 200
; Click X := 931, Y := 38

; WinActivate "Картинка в картинке"
; Sleep 150
; Send "{Space}"
; Sleep 150
; WinMinimize "Картинка в картинке"
WinActivate "DNP"
MouseMove 363, 1025 ; здесь у меня расположен Google Chrome
Sleep 500
Click 368, 956 ; не свернув, активировать хром
; Sleep 1200
Click 158, 92 ; здесь первая вкладка Chrome