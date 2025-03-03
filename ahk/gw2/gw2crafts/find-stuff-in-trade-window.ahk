#Requires AutoHotkey v2.0
#Include ..\utils\defaults-gw2.ahk

TradeWindow := Object()

TradeWindow.MainIconImage := "trade-window.png"
; TradeWindow.CraftingComponent := "crafting-component.png"
; TradeWindow.CogWheel := "cogwheel.png"

; FindWhereIsEverything() {
;     ImageSearch(&xout, &yout, 0, 0, A_ScreenHeight, A_ScreenWidth, TradeWindow.MainIconImage)
;     TradeWindow.SearchCoordsX := xout + 65
;     TradeWindow.SearchCoordsy := yout + 62 

; }



ImageSearch(&xout, &yout, 0, 0, A_ScreenHeight, A_ScreenWidth, TradeWindow.MainIconImage)

MouseMove xout, yout
; Click X := 682, Y := 226 ; trade icon
; Click X := 747, Y := 288 ; search window

; A_Clipboard := "+" 747 - 682 "+" 288-226
;  X := 698, Y := 307 ; discovery
; X := 698, Y := 355 ; production
; X := 973, Y := 291 ; cogwheel
; X := 1014, Y := 311 ; collapse all

; X := 794, Y := 355 ; supposedly collapsed crafting component
; X := 778, Y := 382 ; first item in there