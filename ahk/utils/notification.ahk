#Requires AutoHotkey v2.0
#Include defaults-global.ahk

; debug := 1
; timeStart := A_TickCount

notification(Text, Image := '', logfile := A_MyDocuments "\logs\ahk\" FormatTime(, "yyyy-MM-dd") "\log.txt") {

    FileAppend(FormatTime(,"hh:mm:ss - ") Text, logfile)

    notificationGui := Gui(, Text)
    notificationGui.Opt("+AlwaysOnTop +Disabled -SysMenu +Owner")

    if Image {
        notificationGui.AddPicture(, Image)
        FileAppend(A_WorkingDir "\" Image, logfile)
    }

    notificationGui.Show("NoActivate w200 x1698")
    SetTimer(deleteNotification, 2200)

    deleteNotification() {
        notificationGui.Destroy()
    }
}