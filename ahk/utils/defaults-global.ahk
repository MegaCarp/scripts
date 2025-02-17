#Requires AutoHotkey v2.0
#Include base-sleep-interval.ahk

#Include WorkWithImages.ahk

#Include screenshotScreen.ahk

#Include notification.ahk
#Include ticksTimer.ahk

TempDir := "C:\Users\" A_UserName "\AppData\Local\Temp\"
LogFileName := A_MyDocuments "\logs\ahk\" FormatTime(,"yyyy-MM-dd") ".txt"

screenshotUtilityPath := "C:\Program Files (x86)\MiniCap\MiniCap.exe"

; debug := 1
