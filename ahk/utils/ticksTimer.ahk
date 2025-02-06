#Requires AutoHotkey v2.0
#Include defaults-global.ahk

; debug := 1
; timeStart := A_TickCount

ticksTimer(debug := '', timeStart := '') {
    if debug {
        if timeStart {
            notification("it took " A_TickCount - timeStart "ms")
        } else {
            notification("you haven't set the `"timeStart := A_TickCount`"")
        }
    }
}
