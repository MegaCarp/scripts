#Requires AutoHotkey v2.0
#SingleInstance Force

#Include launch-gw2-and-blish.ahk

#Include Blish_ShowAndHide.ahk
#Include Case_AltTabbedIntoBlish.ahk

#Include ..\..\utils\defaults-global.ahk
#Include chat\technical-guild-chat.ahk
#Include SendItToChat.ahk
#Include time-to-gather.ahk

#Include ..\tp\double-click.ahk
#Include ..\tp\forge-and-fill.ahk

#Include ..\tp\sell-ten.ahk

GoToGw2() {

    if WinExist("ahk_exe Gw2-64.exe") {
        if not WinActive("ahk_exe Gw2-64.exe") {
            WinActivate("ahk_exe Gw2-64.exe")
            w8
        }
    }

}

; F12:: {
;     GoToGw2
;     RecordMousePosition(, ["C:\Users\stash\Documents\scripts\ahk\gw2\tp\tp.png", "this.Anchor"])
; }
