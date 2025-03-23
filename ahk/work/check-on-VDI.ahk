; #Requires AutoHotkey v2.0
; #SingleInstance Force
; #Include ..\utils\defaults-global.ahk

; ; NotifyInAdvance := Notification("In 10 sec there will be a VDI check", "NotifyInAdvance")


; DoTheCheck() {
;     SetTimer DoTheCheck, -300000
;     ; SetTimer ShowNotification, -290000
;     SetTimer ConditionToResetTheChecker

;     MouseGetPos &xpos, &ypos
;     LastWindow := WinGetID("A")
;     WinActivate "DNP"
;     Click 363, 1025, 0 ; здесь у меня расположен Google Chrome
;     Sleep 500
;     Click 368, 956, 10 ; не свернув, активировать хром
;     Click 158, 92, 0 ; здесь первая вкладка Chrome
;     Sleep 200
;     WinActivate LastWindow
;     MouseMove xpos, ypos
;     if WinActive("ahk_exe Gw2-64.exe") != 0 {
;         Sleep 100
;         Send "e"
;         Send "e"
;         Send "e"
;     }
; }

; ; ShowNotification() {
; ;     NotifyInAdvance.Show
; ; }

; ConditionToResetTheChecker() {
;     if WinActive("DNP") {
;         SetTimer DoTheCheck, -300000
;         ; SetTimer ShowNotification, -290000
;     }
; }
