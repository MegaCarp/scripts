#Requires AutoHotkey v2.0
#Include ..\defaults.ahk

w8()
timeStart := A_TickCount
if ImageSearch(&Found_close_windowX, &Found_close_windowY, 0, 0, A_ScreenWidth, A_ScreenHeight, "x-close-window.png") {
    MsgBox "it took " A_TickCount - timeStart "ms"
    ; MouseMove FoundX, FoundY
} else {
    MouseMove 1368, 264
    MouseMove 1430, 320
    MsgBox "nope"
}
