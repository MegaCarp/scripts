#Requires AutoHotkey v2.0
#SingleInstance

#Include ahk\utils\defaults-global.ahk

Run "ahk\utils\killAHK.ahk"
Run "ahk\gw2-kbds-and-scripts.ahk"

F12:: MouseRecorder.Click()

; HotIfWinExist "DNP" ; work hotkeys

; HotIfWinNotExist "DNP"
; Hotkey("``", Run("ahk\work\go-to-VDI-and-open-work-tab.ahk"))

CheckOnVdi()

`:: GoToVDI("And stay in VDI")

^`:: GoToVDI()

;  HotIf
