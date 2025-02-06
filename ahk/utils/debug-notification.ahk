#Requires AutoHotkey v2.0
#Include defaults-global.ahk

; debug := 1
; timeStart := A_TickCount

debugTicksTimer(debug := '', timeStart := A_TickCount) {
    if debug {
        OperationTimedNotification := Gui(, "it took " A_TickCount - timeStart "ms")
        OperationTimedNotification.Opt("+AlwaysOnTop +Disabled -SysMenu +Owner")
        OperationTimedNotification.Show("NoActivate w200 x1698")
        SetTimer(deleteNotification, 2200)

        deleteNotification() {
            OperationTimedNotification.Destroy()
        }
    }
}
