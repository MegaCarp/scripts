#Requires AutoHotkey v2.0

#Include ..\utils\defaults-gw2.ahk

ForgeAndFill(Testing := '') {

    static repeatPress := false

    if !Testing
        if !repeatPress
            repeatPress := true
        else
            repeatPress := false
    else
        if !repeatPress {
            repeatPress := true
            MsgBox 'repeatPress set to true'
        } else {
            repeatPress := false
            MsgBox 'repeatPress set to false'
        }

    MouseGetPos(&outx, &outy)
    RoundsToGo := InputBox(,,, 5).Value

    var := ''

    MouseMove outx, outy, 0
    while (repeatPress AND A_Index < RoundsToGo +1) {
        ; while (repeatPress AND A_Index < RoundsToGo + 1) {
        Click outx, outy ; forge
        w8 2050
        Click outx - (1143 - 1026), outy ; refill
        w8 200
        if Testing {
            MsgBox "round" A_Space A_Index
            var := A_Index
        }
    }

    if Testing AND var
        MsgBox "fin on round №" var A_Space "out of " RoundsToGo
    else if Testing
        MsgBox "fin - aborted, rounds to go was " RoundsToGo

    MouseMove outx, outy, 0

    repeatPress := false
}
