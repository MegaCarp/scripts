#Requires AutoHotkey v2.0
#SingleInstance 

^+Escape:: Run "C:\Program Files\PowerShell\7\pwsh.exe killAHK.ps1"

F12:: Run "ahk\record-mouse-position.ahk"
^F12:: Run "ahk\record-mouse-position_Window.ahk"

Run "ahk\gw2-kbds-and-scripts.ahk"


; HotIfWinExist "DNP" ; work hotkeys

; HotIfWinNotExist "DNP"
; Hotkey("``", Run("ahk\work\go-to-VDI-and-open-work-tab.ahk"))

`:: Run "ahk\work\go-to-VDI-and-open-work-tab.ahk"

^`:: Run "ahk\work\check-on-VDI.ahk"

;  HotIf