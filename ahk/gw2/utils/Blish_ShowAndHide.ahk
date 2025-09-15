#Requires AutoHotkey v2.0
#SingleInstance Force
#Include defaults-gw2.ahk

Blish_ShowAndHide() {
    DetectHiddenWindows 1

    static WaitForGw := ''

    try Gw2ID := WinGetID('ahk_exe Gw2-64.exe')
    catch TargetError {
        Gw2ID := ''
        try WinHide 'ahk_exe Blish HUD.exe'
    }

    if Gw2ID {
        try BlishID := WinGetID('ahk_exe Blish HUD.exe')
        catch TargetError {
            BlishID := ''
            try {
                Run A_MyDocuments "..\games\gw2\blishud\Blish HUD.exe"
            } catch {
                try Run A_MyDocuments "..\games\gw2\addons\Blish HUD.exe"
            }
        }

        if BlishID {

            MouseGetPos , , &id

            switch id {
                case BlishID:
                case Gw2ID:
                    if WaitForGw = 'Yes' OR '' {
                        WinShow BlishID
                        WinActivate Gw2ID
                        WaitForGw := 'Done'
                    }
                default:
                    if WaitForGw != 'Yes' OR '' {
                        WinHide BlishID
                        WaitForGw := 'Yes'
                    }

            }
        }
    }
    DetectHiddenWindows 0
}
