#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ..\utils\defaults-gw2.ahk

Esc:: ExitApp

MsgBox 'get mouse on top left corner of tp'
MouseGetPos &xout, &yout

MouseClickDrag('Left', xout, yout, 500, 200)
w8

; height of an item is about 60px
; with that start pos of mouse, use 440 vertical coord to press an item

NextCoord := 445

EnterItemAndInstabuyIt(HorizontalCoord) {

    Click X := HorizontalCoord, Y := 440

    ; Click X := 937, Y := 567 ; buy instantly
    w8 500
    ; Click ; confirm trade
    Click , X := 1374, Y := 516 ; click off
    w8

}

EnterItemAndInstabuyIt(NextCoord)
w8 500

loop 7 {

    NextCoord := NextCoord + 59
    EnterItemAndInstabuyIt(NextCoord)

}
