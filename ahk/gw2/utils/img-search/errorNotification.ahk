#Requires AutoHotkey v2.0
#Include ..\defaults-gw2.ahk

errorNotification(Text, Image := '', logfile := A_MyDocuments "\logs\ahk\" FormatTime(, "yyyy-MM-dd") ".txt") {
    FileAppend(FormatTime() " - Err! " Text, logfile)

    ErrorGui := Gui(, Text)
    ErrorGui.Opt("+AlwaysOnTop +Disabled -SysMenu +Owner")

    SplitPath(logfile, , &outDir) ; C:\Users\Денис
    screenshotScreen(, , )

    if Image {
        ErrorGui.AddPicture(, A_WorkingDir Image)
        FileAppend(Image, logfile)
    }

    ErrorGui.Show("NoActivate w200 x1698")
    SetTimer(deleteNotification, 2200)

    deleteNotification() {
        ErrorGui.Destroy()
    }
}
