#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ..\utils\defaults-global.ahk

WinActivate "Guild"
    try {
        ActiveWin := WinGetProcessName("A")
    } catch {
        ActiveWin := ''
    }
    if ActiveWin = "Gw2-64.exe" {

        Click X := 15, Y := 20 ; Main menu
        ; w8() 
        Click X := 955, Y := 585, 3 ; Log Out - doesn't actually press anything if in char select already :)
        ; w8(500) 

    }
