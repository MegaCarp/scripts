#Requires AutoHotkey v2.0
#Include defaults-global.ahk

class Notification extends Gui {

    __New(Text, Image := '', isError := "No") {

        super.__New()

        this.Opt("+AlwaysOnTop +Disabled -SysMenu +Owner -Caption")

        if NOT isError = "No" {
            this.BackColor := "808080" ; Gray; https://www.autohotkey.com/docs/v2/misc/Colors.html
        } else {
            this.BackColor := "800000" ; Maroon; https://www.autohotkey.com/docs/v2/misc/Colors.htm
        }

        this.AddText(, Text).GetPos(, , &textWidth)

        imageWidth := 0
        if NOT FileExist(Image) = '' {
            this.AddPicture(, this.MakeDithered(Image)).GetPos(, , &imageWidth)
        }

        if (textWidth >= imageWidth) {
            this.notificationWidth := textWidth
        } else {
            this.notificationWidth := imageWidth
        }

        this.DefaultTimeToShowFor := 2500

        this.TempDir := "C:\Users\" A_UserName "\AppData\Local\Temp\"

    }

    MakeDithered(Image) {
        dithImagePath := this.TempDir "dith-" Image

        if FileExist(dithImagePath) = '' {
            RunWait "magick " A_WorkingDir "\" Image " -colorspace gray -ordered-dither o8x8 " dithImagePath
        }

        if NOT FileExist(dithImagePath) = '' {
            return dithImagePath
        }

    }

    Send(TimeToShowFor := this.DefaultTimeToShowFor) {

        if TimeToShowFor = '' {
            TimeToShowFor := this.DefaultTimeToShowFor
        }

        xPos := A_ScreenWidth - this.notificationWidth - 100
        super.Show("NoActivate AutoSize x" xPos)
        SetTimer(deleteNotification, TimeToShowFor)

        deleteNotification() {
            this.Destroy()
        }
    }
}
