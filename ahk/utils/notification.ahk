#Requires AutoHotkey v2.0
#Include defaults-global.ahk

; debug := 1
; timeStart := A_TickCount

; notification(Text, Image := '', LogFileName := A_MyDocuments "\logs\ahk\" FormatTime(, "yyyy-MM-dd") "\log.txt") {

;     FileAppend(FormatTime(,"hh:mm:ss - ") Text, LogFileName)

;     notificationGui := Gui(, Text)
;     notificationGui.Opt("+AlwaysOnTop +Disabled -SysMenu +Owner")

;     if Image {
;         notificationGui.AddPicture(, Image)
;         FileAppend(A_WorkingDir "\" Image, LogFileName)
;     }

;     notificationGui.Show("NoActivate w200 x1698")
;     SetTimer(deleteNotification, 2200)

;     deleteNotification() {
;         notificationGui.Destroy()
;     }
; }

class Notification extends Gui {

    static LogFileName := A_MyDocuments "\logs\ahk\" FormatTime(, "yyyy-MM-dd") "\log.txt"

    __New(Text, Image) {
        this := Gui(, Text)
        this.Opt("+AlwaysOnTop +Disabled -SysMenu +Owner")

        if Image {
            this.AddPicture(, Image)
        }
    }
    Show() {
        this.super.Show("NoActivate w200 x1698")
        SetTimer(deleteNotification, 2200)

        deleteNotification() {
            this.Destroy()
        }
    }
}