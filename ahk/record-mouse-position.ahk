#Requires AutoHotkey v2.0
#Include utils\base-sleep-interval.ahk

class RecordMousePosition {

    click() {
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

    coords() {
        MouseGetPos &xpos, &ypos
        content := xpos ", " ypos
        WinActivate "Visual Studio Code"
        w8
        Send "{End}"
        w8
        Send content
    }

    RelativeCoords(x, y) {
        ; this here will have a passage being ran with contextual keys, essentially - i want it to break the process if i leave the window or the VSCode

        lastWindow := WinGetID("A")
MouseGetPos &xpos, &ypos

WinActivate "Visual Studio Code"
        while (winget) {
            A_ThisHotkey
        }
        
    }

}
