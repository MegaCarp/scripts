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

    __New(Text, Image := '') {

        super.__New()

        this.Opt("+AlwaysOnTop +Disabled -SysMenu +Owner -Caption")
        this.BackColor := "808080" ; Gray; https://www.autohotkey.com/docs/v2/misc/Colors.html
        this.AddText(, Text).GetPos(, , &textWidth)

        imageWidth := 0
        if NOT FileExist(Image) = '' {
            this.AddPicture(, Image).GetPos(, , &imageWidth)
        }

        if (textWidth >= imageWidth) {
            this.notificationWidth := textWidth
        } else {
            this.notificationWidth := imageWidth
        }

    }

    Show() {

        xPos := A_ScreenWidth - this.notificationWidth - 100
        super.Show("NoActivate AutoSize x" xPos)
        SetTimer(deleteNotification, 2500)

        deleteNotification() {
            this.Destroy()
        }
    }
}

; testNoti := Notification("Попка мипса.", "C:\Users\Денис\Downloads\images.jpg")
; testNoti.Show()

; errorNotification(Text, Image := '', LogFileName := A_MyDocuments "\logs\ahk\" FormatTime(, "yyyy-MM-dd") "\log.txt") {

;     SplitPath(LogFileName, , &outDir) ; C:\Users\Денис
;     fileName := outDir "\" FormatTime(, "hh-mm_") SubStr(Text, 1, 15)

;     notification("Err! " Text, Image, LogFileName)

;     screenshotScreen(fileName)

; }

class ErrorNotification extends Notification {

    __New(Text, Image) {
        super.__New(Text, Image)

        this.BackColor := "800000" ; Maroon; https://www.autohotkey.com/docs/v2/misc/Colors.htm

    }
}

; testNoti := ErrorNotification("Попка мипса.", "C:\Users\Денис\Downloads\images.jpg")
; testNoti.Show()