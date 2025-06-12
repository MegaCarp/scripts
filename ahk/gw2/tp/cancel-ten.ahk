#Requires AutoHotkey v2.0

#Include ..\utils\defaults-gw2.ahk

loop 10 {
    Send "{LButton}"
    w8 200
    Send "{LButton}"
    w8 25
}