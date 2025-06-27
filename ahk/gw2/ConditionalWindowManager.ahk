#Requires AutoHotkey v2.0
#SingleInstance Force

#Include utils\defaults-gw2.ahk

;; REMOVE
; SetTimer BlishVisibilityUtility, 5000

if FileExist("..\games\gw2\blishud\Blish HUD.exe")
    BlishExe := A_MyDocuments "..\games\gw2\blishud\Blish HUD.exe"
else BlishExe := A_MyDocuments "..\games\gw2\addons\Blish HUD.exe"

Gw2Exe := ProcessGetPath("Gw2-64.exe")

BlishVisibilityUtility := ConditionalWindowManager(Gw2Exe, BlishExe)

/**
 * @description Made to bring up and send down Blish HUD if gw2 window exists.
 * @param {'path\to\.exe' | String} WindowConditionPath
 *  - This is the path to window's exe the status of which decides the way the other window acts.
 * @param {'path\to\.exe'| String} WindowReactionPath
 *  - The parth to the window's exe that is being affected in relation to the conditional window.
 * @description The Tester Property affects how the methods work - it's a toggle, effectively working off of an Array of possible values.
 * @description The TestOutput Property is filled if there's stuff to test, going by the Tester Property.
 */
class ConditionalWindowManager {

    __New(WindowConditionPath, WindowReactionPath) {
        this.WindowCondition := WindowConditionPath
        this.WindowReaction := WindowReactionPath
        this.LastWindow := ''

        this.Tester := ''
        this.TestOutput := []
    }

    WindowTest(Window) {

        try
            result := WinGetProcessPath("ahk_exe " Window)
        catch
            result := ''

        if this.Tester = 'All' OR 'Window'
            this.TestOutput.Push [Window, result]

        return result
    }

    PreTest() {
        if !this.WindowTest(this.WindowCondition)
            Run this.WindowCondition

        if !this.WindowTest(this.WindowReaction)
            Run this.WindowReaction

        WinWait this.WindowCondition
        WinWait this.WindowReaction
    }

    __Call() {

        if this.Tester
            this.PreTest

        if this.WindowTest(this.WindowCondition) {

            try WinGetProcessName("A")
            catch {
                WinActivate
                try WinMoveBottom "Blish"
                Send "{AltTab}"
                WinGetProcessName("A")
            }

            if !InStr(WinGetProcessName, "Gw2-64.exe") {
                try WinMinimize "Blish"
                try WinMoveBottom "Blish"
            } else {
                if WinExist("Blish") {
                    WinRestore "Blish"
                    WinActivate "ahk_exe Gw2-64.exe"
                    try WinMoveBottom "Blish"
                } else {
                    try {
                        RunWait A_MyDocuments "..\games\gw2\blishud\Blish HUD.exe"
                    } catch {
                        RunWait A_MyDocuments "..\games\gw2\addons\Blish HUD.exe"
                    }
                }
            }
        }

    }
}
