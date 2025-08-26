#Requires AutoHotkey v2.0
#Include defaults-global.ahk

RecordMousePosition(Mode := "Click`|Coords", AnchorArray := '', ToVisualStudio := 'Yes') {

    switch {
        ; case ( not (RelativeCoords[1] = 0 AND RelativeCoords[2] = 0)): A_Clipboard := RelativeCoords[1] RelativeCoords[2]
        case AnchorArray and FileExist(AnchorArray[1]): RelativeCoordinated(AnchorArray)
        case Mode = "Coords": Coords()
        case Mode = "Click`|Coords" OR "Click": Click()
        default: MsgBox "RecordMousePosition Mode's set wrong" ; TODO notification and some way to test for it
    }

    RelativeCoordinated(AnchorArray, Rectangle := [0, 0, A_ScreenWidth, A_ScreenHeight]) {
        ;;; anchorArr
        ; [png, anchor_variable_name]

        if !ImageSearch(&anchorX, &anchorY, Rectangle[1], Rectangle[2], Rectangle[3], Rectangle[4], AnchorArray[1]) {
            MsgBox "couldn't find it"
            return
        }
       
        MouseGetPos &mouseX, &mouseY
        content := AnchorArray[2] "[1] {+} " mouseX - anchorX ", " AnchorArray[2] "[1] {+} " mouseY - anchorY

        SendToVisualStudio(content, GetUserInput("Comment for Click with Mouse Coords string for VSCode:"))
    }

    Click() {
        MouseGetPos &xpos, &ypos
        content := "Click X := " xpos ", Y := " ypos
        if ToVisualStudio = 'Yes' {
            content := "`n" content
            SendToVisualStudio(content, GetUserInput("Comment for Click with Mouse Coords string for VSCode:"))
            Send "`nw8"
        } else A_Clipboard := content
    }

    Coords() {
        MouseGetPos &xpos, &ypos
        content := xpos ", " ypos
        if ToVisualStudio = 'Yes' {
            SendToVisualStudio(content)
        } else A_Clipboard := content
    }

    SendToVisualStudio(content, comment := '') {

        if comment != '' {
            content := content " `; " comment
        }

        w8
        WinActivate "Visual Studio Code"
        w8
        Send "{End}"
        w8
        Send content
    }

    ; RelativeCoords(OriginPointArray, TargetWindow := WinGetID("A")) {
    ;     ; this here will have a passage being ran with contextual keys, essentially - i want it to break the process if i leave the window or the VSCode

    ;     switch this.RelativeCoordsStep {
    ;         case 1:
    ;             WinActivate TargetWindow
    ;             MouseMove OriginPointArray[1], OriginPointArray[2]

    ;             this.RelativeCoordsStep := 2

    ;         case 2:
    ;             MouseGetPos &xpos, &ypos
    ;             this.GetCommentForRelativeCoords := GetUserInput(CollectCommentAndSetClipboard)

    ;             this.RelativeCoordsStep := 1

    ;     }

    ;     CollectCommentAndSetClipboard(*) {
    ;         if NOT (!this.GetCommentForRelativeCoords.TextField.Value OR this.GetCommentForRelativeCoords.TextField.Value =
    ;             "Leave empty to cancel") {
    ;             this.GetCommentForRelativeCoords.Gui.Hide
    ;             A_Clipboard := xpos - OriginPointArray[1] ", " ypos - OriginPointArray[2] " `; " this.GetCommentForRelativeCoords
    ;                 .TextField.Value
    ;         }
    ;         this.GetCommentForRelativeCoord.Gui.Destroy
    ;     }

    ; MsgBox textField.Value

}
