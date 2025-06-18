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

GoToVDI(BackAndForth := "Yes", LeaveChar := "No") {
    ; SetTimer ShowNotification, -290000
    BlockInput 1
    BlockInput 'MouseMove'

    SetTimer EmergencyReenablementOfInput, -2000

    EmergencyReenablementOfInput() {
        BlockInput 0
        BlockInput 'MouseMoveOff'
        }

    MouseGetPos &xpos, &ypos

    if NOT BackAndForth = "Yes" {

        if NOT LeaveChar = "No" {
            GoToCharSelectIfInGw()
        }

        ; HangUpInTelegram()

    }

    ; HideAndWaitToRestoreBlish()

    LastWindow := WinGetID("A")
    WinActivate "DNP"
    w8
    Click X := 1839, Y := 249 ; click inside VDI to guarantee it's active
    MouseMove 363, 1025 ; здесь у меня расположен Google Chrome
    Sleep 200
    Click 368, 956  ; не свернув, активировать хром
    Click 158, 92 ; здесь первая вкладка Chrome

    BlockInput 0
    BlockInput 'MouseMoveOff'
    SetTimer CheckOnVdi, -300000

    if BackAndForth = "Yes" {
        BlockInput 1
        BlockInput 'MouseMove'
            Sleep 200
        try WinActivate LastWindow
        MouseMove xpos, ypos, 0
        BlockInput 0
        BlockInput 'MouseMoveOff'
            ; if WinActive("ahk_exe Gw2-64.exe") != 0 { ; why the hell does gw get locked into autorun?..
        ;     Sleep 100
        ;     Send "e"
        ;     Send "e"
        ;     Send "e"
        ; }
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
                        Run A_MyDocuments "..\games\gw2\blishud\Blish HUD.exe"
                    } catch {
                        Run A_MyDocuments "..\games\gw2\addons\Blish HUD.exe"
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

        Click X := 15, Y := 20  ; Main menu
        Click X := 955, Y := 585, 3  ; Log Out - doesn't actually press anything if in char select already :)

    }
}

; proce

HangUpInTelegram() {
    if WinExist("ahk_exe Telegram.exe") {
        WinActivate "ahk_exe Telegram.exe"
        w8(1000)
        try {
            ImageSearch(&xout, &yout, 0, 0, A_ScreenWidth, A_ScreenHeight, "..\hangup1.png")
            Click xout, yout
        } catch {
            try {
                ImageSearch(&xout, &yout, 0, 0, A_ScreenWidth, A_ScreenHeight, "..\hangup2.png")
                Click xout, yout
            }
        }
    }
}
