#Requires AutoHotkey v2.0
#SingleInstance Force

#HotIf WinActive("ahk_exe Gw2-64.exe")
#Include ..\utils\defaults-gw2.ahk

Esc:: ExitApp
{
    loop {
        Click
        w8 300
        Click
        w8 300
    }
    ExitApp
}