#Requires AutoHotkey v2.0

#Include utils\defaults-gw2.ahk

RoundRobin := Object()
RoundRobin.CurrentlyOn := ''
RoundRobin.GoToWaypoint := GoToWaypoint

GoToWaypoint() {
    SendItToChat
    Click X := 190, Y := 1010 ; LButton click in chat on the link following the nickname in the last
    w8(standardWaitTime + 900)
    Click X := 962, Y := 541 ; wait for map to show the wp then double click it
    Click
}

RoundRobin.GoingRound()
switch RoundRobin.CurrentlyOn {
    case "[&BKgDAAA=]": ; diessa gate wp, Black Citadel
        RoundRobin.CurrentlyOn := "[&BAwEAAA =]" ; commodore's quarters wp; Lion's Arch
        A_Clipboard := RoundRobin.CurrentlyOn
        RoundRobin.GoToWaypoint

    case "[&BAwEAAA =]": ; commodore's quarters wp; Lion's Arch
        RoundRobin.CurrentlyOn := "[&BMwHAAA =]" ; ogre camp wp; Tangled Depth
        A_Clipboard := RoundRobin.CurrentlyOn
        RoundRobin.GoToWaypoint

    case "[&BMwHAAA =]": ; ogre camp wp; Tangled Depth
        RoundRobin.CurrentlyOn := "[&BNYHAAA =]" ; wanderer's wp; Auric Basin
        A_Clipboard := RoundRobin.CurrentlyOn
        RoundRobin.GoToWaypoint

    default:
        RoundRobin.CurrentlyOn := "[&BKgDAAA=]" ; diessa gate wp, Black Citadel
        A_Clipboard := RoundRobin.CurrentlyOn
        RoundRobin.GoToWaypoint

}

; [&BKgDAAA =] ; diessa gate wp, Black Citadel
; ; todo press X
; ; todo open inv, find and press lion's arch key
; ; todo repeat

; [&BAwEAAA =] ; commodore's quarters wp; Lion's Arch
; ; todo press X
; [&BMwHAAA =] ; ogre camp wp; Tangled Depth
; ; todo press X
; [&BNYHAAA =] ; wanderer's wp; Auric Basin
