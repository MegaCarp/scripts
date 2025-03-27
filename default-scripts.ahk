#Requires AutoHotkey v2.0
#SingleInstance

#Include ahk\utils\defaults-global.ahk

Run "ahk\utils\killAHK.ahk"
Run "ahk\gw2-kbds-and-scripts.ahk"

F12:: MouseRecorder.Click()

; F1:: RunWait "ahk\gw2\research-item-name-on-bltc.ahk"
; F5:: RunWait "ahk\рассылка-в-тайме.ahk"

; HotIfWinExist "DNP" ; work hotkeys

; HotIfWinNotExist "DNP"
; Hotkey("``", Run("ahk\work\go-to-VDI-and-open-work-tab.ahk"))

; CheckOnVdi()

; `:: GoToVDI("And stay in VDI", 1)

; ^`:: GoToVDI()

;  HotIf
