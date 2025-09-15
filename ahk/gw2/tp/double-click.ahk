#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ..\utils\defaults-gw2.ahk

Gw2_DoubleClicker(Coord_X, Coord_Y, Delay := 300) {
    loop {

        MouseGetPos(, , &WindowId)

        try if WinGetID("ahk_exe Gw2-64.exe") != WindowId {
            MsgBox 'window is not gw, exit'
            ExitApp
        }
        catch
            ExitApp

        BlockInput('MouseMove')
        MouseMove Coord_X, Coord_Y, 0
        DoubleClicker(Delay)
        BlockInput('MouseMoveOff')
    }
}
