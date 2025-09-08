#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ..\utils\defaults-gw2.ahk

ForgeAndFill(Coord_X, Coord_Y) {
    loop {

        MouseGetPos(, , &WindowId)

        try if WinGetID("ahk_exe Gw2-64.exe") != WindowId {
            MsgBox 'window is not gw, exit'
            ExitApp
        }
        catch
            ExitApp

        BlockInput('MouseMove')
        MouseMove Coord_X, Coord_Y, 0 ; forge
        Click
        BlockInput('MouseMoveOff')

        w8 2050

        try if WinGetID("ahk_exe Gw2-64.exe") != WindowId {
            MsgBox 'window is not gw, exit'
            ExitApp
        }
        catch
            ExitApp

        BlockInput('MouseMove')
        MouseMove Coord_X - (1143 - 1026), Coord_Y, 0 ; refill
        Click
        BlockInput('MouseMoveOff')
        w8 200
    }
}
