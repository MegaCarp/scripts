#Requires AutoHotkey v2.0

#Include local-vars.ahk

#Include ..\lib\lib_runcmd.ahk
#Include ..\lib\lib_dsvparser-ahk2.ahk
#Include ..\lib\lib_mutex.ahk

#Include ..\work\go-to-VDI.ahk

#Include base-sleep-interval.ahk
#Include TestableDataForSwitching.ahk
#Include TestingSuite.ahk

; #Include SearchableImage.ahk

#Include Screenshot.ahk
#Include GetUserInput.ahk

#Include record-mouse-position.ahk

#Include logger.ahk
#Include notification.ahk

#Include ticksTimer.ahk

#Include toggleNightlight.ahk

LogFileName := A_MyDocuments "\logs\ahk\" FormatTime(,"yyyy-MM-dd") ".txt"

; debug := 1
