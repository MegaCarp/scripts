HideAndWaitToRestoreBlish

; WinMinimize "Blish"
; ; WinRestore "Blish"
; MsgBox WinGetProcessName("A")

HideAndWaitToRestoreBlish() {
    try {
        WinMinimize "Blish HUD"
        MsgBox "yes blish, hide"
    } catch {
        MsgBox "No blish"
    }

    if WinExist("ahk_exe Gw2-64.exe") {
        SetTimer WaitForGw
        MsgBox "gw2 exists, setting timer"
    }

    WaitForGw() {
        try {
            if (WinGetProcessName("A") = "Gw2-64.exe") {
                MsgBox "active win is gw2"
                if WinExist("Blish HUD") {
                    WinRestore "Blish"
                    WinActivate "ahk_exe Gw2-64.exe"
                    SetTimer WaitForGw, 0
                    MsgBox "restored blish, returned gw to front, deleted timer"
                } else {
                    Run "C:\Users\Денис\games\gw2\blishud\Blish HUD.exe"
                    MsgBox "blish is ded, starting it up"
                    WinWait "Blish"
                    MsgBox "blish is up"
                    WinActivate "ahk_exe Gw2-64.exe"
                    SetTimer WaitForGw, 0
                    MsgBox "blish is offline, ran blish, after it went up, returned gw to front, deleted timer"
                }
            }
        }
    }
}
