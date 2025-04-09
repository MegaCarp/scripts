#Requires AutoHotkey v2.0

#Include ..\..\utils\defaults-global.ahk
#Include chat\technical-guild-chat.ahk
#Include SendItToChat.ahk
#Include time-to-gather.ahk

GoToGw2() {

    if WinExist("ahk_exe Gw2-64.exe") {
        if not WinActive("ahk_exe Gw2-64.exe") {
            WinActivate("ahk_exe Gw2-64.exe")
            w8
        }
    }

}
