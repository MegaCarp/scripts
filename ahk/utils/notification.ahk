#Requires AutoHotkey v2.0
#Include defaults-global.ahk

Notification_Oneliner(Text, Image := '', isError := "No") {
    
}
class Notification extends Gui {

    __New(Text, Image := '', isError := "No") {

        this.Opt("+AlwaysOnTop +Disabled -SysMenu +Owner -Caption")

        if isError = "No" {
            this.BackColor := "808080" ; Gray; https://www.autohotkey.com/docs/v2/misc/Colors.html
        } else {
            this.BackColor := "800000" ; Maroon; https://www.autohotkey.com/docs/v2/misc/Colors.htm
        }

        this.AddText(, Text).GetPos(, , &textWidth)

        this.TempDir := "C:\Users\" A_UserName "\AppData\Local\Temp\"

        this.DefaultTimeToShowFor := 2500

        imageWidth := 0

        if IsSet(imageWidth) = 0

        if (textWidth >= imageWidth) {
            if NOT Image = '' {


            } 
            this.notificationWidth := textWidth

        } else {

            this.notificationWidth := imageWidth

        }

    }


    Send(TimeToShowFor := this.DefaultTimeToShowFor) {


        xPos := A_ScreenWidth - this.notificationWidth - 100
        super.Show("NoActivate AutoSize x" xPos)
        SetTimer(deleteNotification, TimeToShowFor)

        deleteNotification() {
            this.Logger.Log "Destroying notification"
            this.Destroy()
        }
    }
}
