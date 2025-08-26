#Requires AutoHotkey v2.0
#SingleInstance

#Include ahk\utils\defaults-global.ahk


Run "ahk\utils\killAHK.ahk"
Run "ahk\gw2-kbds-and-scripts.ahk"

F12:: RecordMousePosition

; F1:: RunWait "ahk\gw2\research-item-name-on-bltc.ahk"
; F5:: RunWait "ahk\рассылка-в-тайме.ahk"

; F2:: RunWait "ahk\gw2\tp\cancel-ten.ahk"

; HotIfWinExist "DNP" ; work hotkeys

; HotIfWinNotExist "DNP"
; Hotkey("``", Run("ahk\work\go-to-VDI-and-open-work-tab.ahk"))

CheckOnVdi()

; `:: GoToVDI("And stay in VDI", 'leave char')
; `:: GoToVDI("And stay in VDI")
; ^`:: GoToVDI()

;  HotIf

; #HotIf "ahk_exe firefox.exe"
; MButton:: Send "{RButton}"
; RButton:: Send "{MButton}"
; #HotIf
