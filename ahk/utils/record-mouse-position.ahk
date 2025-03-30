#Requires AutoHotkey v2.0
#Include defaults-global.ahk


class RecordMousePosition extends Object {

    __New() {
        ; super.__New() ; seems to break the class

        this.RelativeCoordsStep := 1
    }

    Click() {
        MouseGetPos &xpos, &ypos
        content := "`n" "Click X := " xpos ", Y := " ypos 
        ToVisualStudio(content, " ")
    }

    Coords() {
        MouseGetPos &xpos, &ypos
        content := xpos ", " ypos
        ToVisualStudio(content)
    }

    RelativeCoords(OriginPointArray, TargetWindow := WinGetID("A")) {
        ; this here will have a passage being ran with contextual keys, essentially - i want it to break the process if i leave the window or the VSCode

        switch this.RelativeCoordsStep {
            case 1:
                WinActivate TargetWindow
                MouseMove OriginPointArray[1], OriginPointArray[2]

                this.RelativeCoordsStep := 2

            case 2:
                MouseGetPos &xpos, &ypos
                this.GetCommentForRelativeCoords := GetUserInput(CollectCommentAndSetClipboard)

                this.RelativeCoordsStep := 1

        }

        CollectCommentAndSetClipboard(*) {
            if NOT (!this.GetCommentForRelativeCoords.TextField.Value OR this.GetCommentForRelativeCoords.TextField.Value =
                "Leave empty to cancel") {
                this.GetCommentForRelativeCoords.Gui.Hide
                A_Clipboard := xpos - OriginPointArray[1] ", " ypos - OriginPointArray[2] " `; " this.GetCommentForRelativeCoords
                    .TextField.Value
            }
            this.GetCommentForRelativeCoord.Gui.Destroy
        }

        ; MsgBox textField.Value
    }

}

ToVisualStudio(content, comment := '') {
    w8
    WinActivate "Visual Studio Code"
    w8
    Send "{End}"
    w8
    Send content
    if comment != '' {
        w8
        Send "`n" "w8" "{Up}{End}{Space};{Space}" comment
    }
}
