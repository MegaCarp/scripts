#Requires AutoHotkey v2.0
#Include ..\utils\defaults-gw2.ahk

TradeWindow := Object()

TradeWindow.MainIconImage := "trade-window.png"
; TradeWindow.CraftingComponent := "crafting-component.png"
; TradeWindow.CogWheel := "cogwheel.png"

FindWhereIsEverything() {
    ImageSearch(&xout, &yout, 0, 0, A_ScreenHeight, A_ScreenWidth, TradeWindow.MainIconImage)
    TradeWindow.SearchCoordsX := xout + 65
    TradeWindow.SearchCoordsy := yout + 62

    TradeWindow.Discovery := xout + 16 yout + 81		 ; discovery
    TradeWindow.production := xout + 16, yout + 129		 ; production;
    TradeWindow.cogwheelX := xout + 291		 ; cogwheel
    TradeWindow.cogwheelY := yout + 65		 ; cogwheel
    TradeWindow.collapseAll := xout + 332, yout + 85		 ; collapse all
    TradeWindow.craftingComponent := xout + 112, yout + 129		 ; supposedly collapsed “crafting component”
    TradeWindow.firstItemUnderCraftComp := xout + 96, yout + 156		 ; first item in there

}

FindWhereIsEverything()

; ImageSearch(&xout, &yout, 0, 0, A_ScreenHeight, A_ScreenWidth, TradeWindow.MainIconImage)

MouseMove TradeWindow.cogwheelX, TradeWindow.cogwheelY

; Click X := 682, Y := 226 ; trade icon
; Click X := 747, Y := 288 ; search window

; A_Clipboard := "+" 747 - 682 "+" 288-226
;  X := 698, Y := 307 ; discovery
; X := 698, Y := 355 ; production
; X := 973, Y := 291 ; cogwheel
; X := 1014, Y := 311 ; collapse all

; X := 794, Y := 355 ; supposedly collapsed crafting component
; X := 778, Y := 382 ; first item in there
Click X := 557, Y := 294 ; in discovery top item
Click X := 1431, Y := 191 ; in discovery X to close
Click X := 1075, Y := 835 ; in discovery Craft
Click X := 1041, Y := 737 ; in production Craft