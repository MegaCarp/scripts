#Requires AutoHotkey v2.0
#Include defaults-gw2.ahk

; F5:: {
;     Send "F5"
;     timer := A_TickCount
;     Sleep 300
;     while ImageSearch(&outx, &outy, 598, 761, 1286, 913, "C:\Users\Денис\Documents\Guild Wars 2\Screens\gw021.jpg") = 1 {
;     }

;     A_Clipboard := timer - A_TickCount
;     MsgBox := timer - A_TickCount
; }

+F5:: {
    Send "F5"
    ; timer := A_TickCount
    Sleep 300
    SetTimer sendEsc
    ; success := ''

    ; while NOT success = 1 {
    ;     if ImageSearch(&outx, &outy, 598, 761, 1286, 913, "C:\Users\Денис\Documents\Guild Wars 2\Screens\gw021.jpg") = 1 {
    ;         success := 1
    ;     }
    ; }

    ; A_Clipboard := timer - A_TickCount
    ; MsgBox := timer - A_TickCount
}

sendEsc(*) {
    Send "{Escape}"
}
