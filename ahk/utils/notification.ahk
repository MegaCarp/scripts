#Requires AutoHotkey v2.0
#Include defaults-global.ahk

class Notification extends Gui {

    __New(Text, ProcessTree, Image := '', isError := "No", Debug := 0) {

        if isError = "No" {
            this.ProcessTree := ProcessTree "\Notification"
        } else {
            this.ProcessTree := ProcessTree "\ErrorNotification"
        }

        ; this.Opt("+AlwaysOnTop +Disabled -SysMenu +Owner -Caption")
        super.__New("+AlwaysOnTop +Disabled -SysMenu +Owner -Caption", ProcessTree)

        this.Logger := Logger(this.ProcessTree)


        if isError = "No" {
            this.BackColor := "808080" ; Gray; https://www.autohotkey.com/docs/v2/misc/Colors.html
        } else {
            this.BackColor := "800000" ; Maroon; https://www.autohotkey.com/docs/v2/misc/Colors.htm
        }

        this.AddText(, Text).GetPos(, , &textWidth)

        this.TempDir := "C:\Users\" A_UserName "\AppData\Local\Temp\"

        this.DefaultTimeToShowFor := 2500

        this.Logger.Log("Creating a notification, with text " Text "with image - `"" Image "`", TempDir is " this
            .TempDir)

        imageWidth := 0
        if NOT FileExist(Image) = '' {

            this.dithImage := this.MakeDithered(Image)
            this.Logger.Log("Image " Image " exists")
            this.AddPicture(, this.dithImage).GetPos(, , &imageWidth)

        } else if NOT Image = '' {

            this.Logger.Log("Image path" Image " is incorrect!", "Yes")

        }

        if (textWidth >= imageWidth) {
            if NOT Image = '' {

                this.Logger.Log "TEXT is wider than the Image"

            } else {
                this.Logger.Log "No image, setting width by Text width"
            }
            this.notificationWidth := textWidth

        } else {

            this.Logger.Log "IMAGE is wider than the Text"
            this.notificationWidth := imageWidth

        }

    }

    MakeDithered(Image) {
        dithImagePath := this.TempDir "dith-" Image

        if FileExist(dithImagePath) = '' {

            this.Logger.Log dithImagePath " doesn't exist, creating"

            ;; TODO create try-catch for "imagemagick not being installed" case
            RunWait "magick " A_WorkingDir "\" Image " -colorspace gray -ordered-dither o8x8 " dithImagePath

        } else {
            this.Logger.Log dithImagePath "exists"
            return dithImagePath
        }

    }

    Send(TimeToShowFor := this.DefaultTimeToShowFor) {

        if TimeToShowFor = this.DefaultTimeToShowFor {
            this.Logger.Log "Sending notification using default TimeToShowFor - " TimeToShowFor
        } else {
            this.Logger.Log "Sending notification using manually set TimeToShowFor - " TimeToShowFor
        }

        xPos := A_ScreenWidth - this.notificationWidth - 100
        super.Show("NoActivate AutoSize x" xPos)
        SetTimer(deleteNotification, TimeToShowFor)

        deleteNotification() {
            this.Logger.Log "Destroying notification"
            this.Destroy()
        }
    }
}
