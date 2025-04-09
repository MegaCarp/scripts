#Requires AutoHotkey v2.0
#Include defaults-gw2.ahk

tech_TimingGather(SwapOrStow := "Swap", TestingTheResult := "No") {
    GoToGw2
    static tech_TimingGather_Depth := 0
    static tech_TimingGather_Timer := 0

    if TestingTheResult = "No" {
        if tech_TimingGather_Depth > 0 ; this is the second press then
        {
            SwapOrStow_func(SwapOrStow)
            A_Clipboard := A_TickCount - tech_TimingGather_Timer ; TODO implement to save or not to save through GUI
            tech_TimingGather_Depth := 0
            SetTimer ResetTheDepth, 0
        } else ; this is the first press
        {
            Click X := 1263, Y := 756 ; gather
            tech_TimingGather_Timer := A_TickCount
            tech_TimingGather_Depth := 1
            SetTimer ResetTheDepth, -5500
        }

    } else {

        Click X := 1263, Y := 756 ; gather

        switch TestingTheResult {
            case 1:
                w8 4550 ; seems good
                SwapOrStow_func(SwapOrStow)
            case 2:
                w8 4760 ; embiggen
                ; 4953
                SwapOrStow_func(SwapOrStow)
            case 3:
                w8 2055 ; prefinal
                SwapOrStow_func(SwapOrStow)
        }
        tech_TimingGather_Depth := 0
        SetTimer ResetTheDepth, 0
    }

    SwapOrStow_func(SwapOrStow) {
        if SwapOrStow = "Swap" {
            Send "{Ctrl down}{Alt Down}{Shift down}={Ctrl up}{Alt up}{Shift up}" ; swap weapon
            Send "^{Delete}{RButton down}{RButton up}"
        } else {
            Send "{Ctrl down}{Alt Down}{Shift down}m{Ctrl up}{Alt up}{Shift up}" ; stow weapon
            Send "^{Delete}{RButton down}{RButton up}"
        }
    }

    ResetTheDepth() {
        tech_TimingGather_Depth := 0
    }
}

GatherBountifully(Mode := "Rocks(1), Lumber(2) or Bush(3)", ForcePrompt := "No", Noninteractive := "No") {

    static GatherBountifully_Mode := Mode

    if Noninteractive != "No" ; assuming this is a test run, let's add the original value from the memory of the last usage to the output - can make a wrapper function to the tester to restore the memory
    {
        StoreMode := GatherBountifully_Mode
    }

    if ForcePrompt != "No" OR (Mode = "Rocks(1), Lumber(2) or Bush(3)" AND GatherBountifully_Mode = 0) ; prompt for mode if the mode hasn't being set by a previous interaction and if the mode in the command is the default. Can be forced by a flag
    {
        GatherBountifully_Mode := GetUserInput("Rocks(1), Lumber(2) or Bush(3)", , "Gather Bountifully prompt for mode"
        )
    } else if Mode != "Rocks(1), Lumber(2) or Bush(3)" {
        GatherBountifully_Mode := Mode
    }

    switch GatherBountifully_Mode, 0 {
        case "Rocks(1), Lumber(2) or Bush(3)", "Rocks", "R", "1":
            firstGather := 1600
            secondGather := 4550
            returner := "Rocks or 1 or R"
        case "Lumber", "L", 2:
            firstGather := 1600
            secondGather := 4760
            returner := "Lumber or L or 2"
        case "Bush", "B", 3:
            firstGather := 2055
            secondGather := 2055
            returner := "Bush or B or 3"
        default:
            return "Incorrect Mode"
    }

    if Noninteractive = "No" {
        Send "i" ; open inventory
        Click X := 1263, Y := 756 ; gather
        w8 firstGather
        Send "{Ctrl down}{Alt Down}{Shift down}m{Ctrl up}{Alt up}{Shift up}" ; stow weapon
        w8
        Click X := 848, Y := 676, 2 ; first slot of the inventory
        Click X := 1263, Y := 756 ; gather
        w8 secondGather

        Send "{Ctrl down}{Alt Down}{Shift down}m{Ctrl up}{Alt up}{Shift up}" ; stow weapon
        Send "^{Delete}{RButton down}{RButton up}" ; autorun
        Click 848, 676, 2 ; first slot of the inventory
        w8
        Send "i" ; close inventory
    } else {
        returner := [returner, StoreMode]
        return returner
    }
}

; F5:: {
;     Send "F5"
;     timer := A_TickCount
;     Sleep 300
;     while ImageSearch(&outx, &outy, 598, 761, 1286, 913, "C:\Users\Денис\Documents\Guild Wars 2\Screens\gw021.jpg") = 1 {
;     }

;     A_Clipboard := timer - A_TickCount
;     MsgBox := timer - A_TickCount
; }

; +F5:: {
;     Send "F5"
;     ; timer := A_TickCount
;     Sleep 300
;     SetTimer sendEsc
;     ; success := ''

;     ; while NOT success = 1 {
;     ;     if ImageSearch(&outx, &outy, 598, 761, 1286, 913, "C:\Users\Денис\Documents\Guild Wars 2\Screens\gw021.jpg") = 1 {
;     ;         success := 1
;     ;     }
;     ; }

;     ; A_Clipboard := timer - A_TickCount
;     ; MsgBox := timer - A_TickCount
;     sendEsc(*) {
;         Send "{Escape}"
;     }
; }
