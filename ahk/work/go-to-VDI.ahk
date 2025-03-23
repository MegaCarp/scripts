#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ..\utils\defaults-global.ahk

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

    MouseGetPos &xpos, &ypos

    if NOT BackAndForth = "Yes" {
        GoToCharSelectIfInGw()
    }

    HideAndWaitToRestoreBlish()

    LastWindow := WinGetID("A")
    WinActivate "DNP"
    w8
    Click X := 1619, Y := 1027 ; click inside VDI to guarantee it's active
    Click 363, 1025 ; здесь у меня расположен Google Chrome
    Sleep 200
    Click 368, 956  ; не свернув, активировать хром
    Click 158, 92 ; здесь первая вкладка Chrome

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
        try {
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
    }
}

GoToCharSelectIfInGw() {
    try {
        ActiveWin := WinGetProcessName("A")
    } catch {
        ActiveWin := ''
    }
    if ActiveWin = "Gw2-64.exe" {

        Click X := 15, Y := 20
        w8(1000) ; Main menu
        Click X := 955, Y := 585
        ; w8(500) ; Log Out - doesn't actually press anything if in char select already :)

    }
}
