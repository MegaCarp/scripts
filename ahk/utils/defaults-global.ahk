#Requires AutoHotkey v2.0
#Include base-sleep-interval.ahk

#Include WorkWithImages.ahk

#Include Screenshot.ahkcreenshot.ahk

#Include notification.ahk
#Include ticksTimer.ahk

#Include toggleNightlight.ahk

TempDir := "C:\Users\" A_UserName "\AppData\Local\Temp\"
LogFileName := A_MyDocuments "\logs\ahk\" FormatTime(,"yyyy-MM-dd") ".txt"

; debug := 1
