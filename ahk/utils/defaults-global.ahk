#Requires AutoHotkey v2.0
#Include debug-notification.ahk
#Include base-sleep-interval.ahk
#Include screenshotScreen.ahk

logfile := A_MyDocuments "\logs\ahk\" FormatTime(,"yyyy-MM-dd") ".txt"

screenshotUtilityPath := "C:\Program Files (x86)\MiniCap\MiniCap.exe"

debug := ''
