#Requires AutoHotkey v2.0

#Include ..\..\utils\defaults-global.ahk
#Include chat\technical-guild-chat.ahk
#Include SendItToChat.ahk

if not WinActive("ahk_exe Gw2-64.exe") {
    WinActivate("ahk_exe Gw2-64.exe")
    w8(200)
}