#Requires AutoHotkey v2.0

#Include ..\utils\defaults-gw2.ahk

BlockInput 'Mouse'
BlockInput 'MouseMove'
loop 10 {
    Send "{LButton}"
    w8 650
    Send "{LButton}"
    w8 150
}
; BlockInput 'Mouse Off'
BlockInput 'MouseMoveOff'
