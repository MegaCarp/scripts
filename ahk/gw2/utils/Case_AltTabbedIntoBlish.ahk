#Requires AutoHotkey v2.0
#SingleInstance Force
#Include defaults-gw2.ahk

Case_AltTabbedIntoBlish() {
    Send '!{Tab}'

    DoTheCheck() {
        BlishMaybe := ''
        try BlishMaybe := WinActive('A')
        catch TargetError
            SetTimer DoTheCheck, -500

        BlishID := ''
        if BlishMaybe {
            try BlishID := WinGetID('ahk_exe Blish HUD.exe')
        }

        if BlishID AND BlishID = BlishMaybe {
            GoToGw2
            WinHide BlishID
            Send '!{Tab}'
        }
    }

    DoTheCheck

}
