#Requires AutoHotkey v2.0
#SingleInstance Force

#Include utils\defaults-gw2.ahk

SetTimer BlishVisibilityUtility

BlishVisibilityUtility() {

    if WinExist("Gw2-64.exe") {

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
