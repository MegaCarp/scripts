#Requires AutoHotkey v2.0
#SingleInstance Force

#Include ..\utils\defaults-gw2.ahk

#HotIf WinActive("ahk_exe firefox.exe")

F1:: {
    BlockInput 1
    Click
    w8
    Send "^c"
    w8
    GoToGw2
    BlockInput 0
}

F2:: GoToGw2

#HotIf WinActive("ahk_exe Gw2-64.exe")

F2:: {
    BlockInput 1
    Click
    w8
    SendPlay '^a'
}

F1:: {
    BlockInput 1
    WinActivate "ahk_exe firefox.exe"
    BlockInput 0
}
