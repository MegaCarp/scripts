#Requires AutoHotkey v2.0
#SingleInstance
#Include utils\defaults-gw2.ahk

class RoundRobin extends Object

RoundRobin.Waypoints := Map
RoundRobin.CurrentlyOnNum := 0

RoundRobin.Waypoints := []
RoundRobin.Waypoints[1]

; RoundRobin.Waypoints.ChatCode
; RoundRobin.Waypoints.ReadableTitle := ''

RoundRobin.GoToWaypoint := GoToWaypoint
RoundRobin.GoingRound := GoingRound


GoToWaypoint(this) {
    SendItToChat
    Click X := 190, Y := 1010 ; LButton click in chat on the link following the nickname in the last
    w8(standardWaitTime + 900)
    Click X := 962, Y := 541 ; wait for map to show the wp then double click it
    Click
}

^f10:: RoundRobin.GoingRound

GoingRound(this) {
    switch RoundRobin.CurrentWaypoint.ChatCode {
        case "[&BKgDAAA=]": ; diessa gate wp, Black Citadel
            RoundRobin.CurrentWaypoint.ChatCode := "[&BAwEAAA=]" ; commodore's quarters wp; Lion's Arch
            A_Clipboard := RoundRobin.CurrentWaypoint.ChatCode
            RoundRobin.GoToWaypoint

        case "[&BAwEAAA=]": ; commodore's quarters wp; Lion's Arch
            RoundRobin.CurrentWaypoint.ChatCode := "[&BMwHAAA=]" ; ogre camp wp; Tangled Depth
            A_Clipboard := RoundRobin.CurrentWaypoint.ChatCode
            RoundRobin.GoToWaypoint

        case "[&BMwHAAA=]": ; ogre camp wp; Tangled Depth
            RoundRobin.CurrentWaypoint.ChatCode := "[&BNYHAAA=]" ; wanderer's wp; Auric Basin
            A_Clipboard := RoundRobin.CurrentWaypoint.ChatCode
            RoundRobin.GoToWaypoint

        default:
            RoundRobin.CurrentWaypoint.ChatCode := "[&BKgDAAA=]" ; diessa gate wp, Black Citadel
            A_Clipboard := RoundRobin.CurrentWaypoint.ChatCode
            RoundRobin.GoToWaypoint

        case "[&BKgDAAA=]": ; diessa gate wp, Black Citadel
            RoundRobin.CurrentWaypoint.ChatCode := "[&BAwEAAA=]" ; commodore's quarters wp; Lion's Arch
            MsgBox "it's currently diessa gate wp, Black Citadel`n"

        case "[&BAwEAAA=]": ; commodore's quarters wp; Lion's Arch
            RoundRobin.CurrentWaypoint.ChatCode := "[&BMwHAAA=]" ; ogre camp wp; Tangled Depth

        case "[&BMwHAAA=]": ; ogre camp wp; Tangled Depth
            RoundRobin.CurrentWaypoint.ChatCode := "[&BNYHAAA=]" ; wanderer's wp; Auric Basin

        default:
            RoundRobin.CurrentWaypoint.ChatCode := "[&BKgDAAA=]" ; diessa gate wp, Black Citadel

    }
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
