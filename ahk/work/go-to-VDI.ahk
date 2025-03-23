#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ..\utils\defaults-global.ahk

CheckOnVdi()

; NotifyInAdvance := Notification("In 10 sec there will be a VDI check", "NotifyInAdvance")

CheckOnVdi() {
    if WinExist("DNP") {

        SetTimer ConditionToResetTheChecker ; if active win is VDI then reset the timer on the checker

        if WinActive("DNP") = 0 {
            GoToVDI()
        }

        ; SetTimer ShowNotification, -290000
    } else {
        ; if DNP is no longer to be found, delete the timer
        SetTimer ConditionToResetTheChecker, 0
    }

    SetTimer CheckOnVdi, -300000 ; recurse me daddy
}

GoToVDI(BackAndForth := "Yes") {
    ; SetTimer ShowNotification, -290000

    HideAndWaitToRestoreBlish()

    MouseGetPos &xpos, &ypos
    LastWindow := WinGetID("A")
    WinActivate "DNP"
    Click 363, 1025, 0 ; здесь у меня расположен Google Chrome
    Sleep 500
    Click 368, 956, 10 ; не свернув, активировать хром
    Click 158, 92, 0 ; здесь первая вкладка Chrome

    SetTimer CheckOnVdi, -300000

    if BackAndForth = "Yes" {
        Sleep 200
        WinActivate LastWindow
        MouseMove xpos, ypos, 0
        if WinActive("ahk_exe Gw2-64.exe") != 0 { ; why the hell does gw get locked into autorun?..
            Sleep 100
            Send "e"
            Send "e"
            Send "e"
        }
    }
}

; ShowNotification() {
;     NotifyInAdvance.Show
; }

ConditionToResetTheChecker() {
    if WinActive("DNP") {
        SetTimer CheckOnVdi, -300000
        ; SetTimer ShowNotification, -290000
    }
}

HideAndWaitToRestoreBlish() {
    try {
        WinMinimize "Blish"
    }

    if WinExist("ahk_exe Gw2-64.exe") {
        SetTimer WaitForGw
    }

    WaitForGw() {
        if (WinGetProcessName("A") = "Gw2-64.exe") {
            if WinExist("Blish") {
                WinRestore "Blish"
                WinActivate "ahk_exe Gw2-64.exe"
                SetTimer WaitForGw, 0
            } else {
                try {
                    Run "C:\Users\Денис\games\gw2\blishud\Blish HUD.exe"
                } catch {
                    MsgBox "blish is offline and couldn't find it"
                }
                SetTimer WaitForGw, 0
            }
        }
    }
