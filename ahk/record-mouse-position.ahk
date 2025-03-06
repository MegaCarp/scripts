#Requires AutoHotkey v2.0
#Include utils\defaults-global.ahk

class RecordMousePosition {

    ; this.Mode := "Click"

    ; this.notification := Notification()

    ; Do(Mode := this.Mode, BaseCoordsArrayIfRelative := [,]) {
    ;     switch Mode {
    ;         case "Click": this.Click

    ;         case "Coords": this.Coords

    ;         case "RelativeCoords": this.RelativeCoords(BaseCoordsArrayIfRelative, WinGetID("A"))

    ;         default:

    ;     }
    ; }

    Click() {
        MouseGetPos &xpos, &ypos
        content := "`n" "Click X := " xpos ", Y := " ypos "`n" "w8"
        WinActivate "Visual Studio Code"
        w8
        Send "{End}"
        w8
        Send content
        w8
        Send "^{Left}^{Left}^{Right}{Space};{Space}"
    }

    Coords() {
        MouseGetPos &xpos, &ypos
        content := xpos ", " ypos
        WinActivate "Visual Studio Code"
        w8
        Send "{End}"
        w8
        Send content
    }

    RelativeCoords(OriginPointArray, TargetWindow := WinGetID("A")) {
        ; this here will have a passage being ran with contextual keys, essentially - i want it to break the process if i leave the window or the VSCode

        WinActivate TargetWindow
        Sleep 100 ; TODO
        MouseGetPos &xpos, &ypos
        getComment := Gui()
        textField := getComment.AddEdit(, "Leave empty to cancel")

        getComment.Show
        textField.Focus()
        Send "{Control down}a{Control up}"
        textField.OnEvent("Escape", CollectCommentAndSetClipboard())
        textField.OnEvent("LoseFocus", CollectCommentAndSetClipboard())

        ; CollectCommentAndSetClipboard() {
        ;     if NOT (!textField.Value OR textField.Value = "Leave empty to cancel") {
        ;         getComment.Hide
        ;         A_Clipboard := xpos - OriginPointArray[1] ", " ypos - OriginPointArray[2] " `;" textField.Value
        ;     }
        ;     getComment.Destroy
        ; }
        MsgBox getComment.Value
    }

}
