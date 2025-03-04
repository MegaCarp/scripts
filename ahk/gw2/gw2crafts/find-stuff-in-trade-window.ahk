#Requires AutoHotkey v2.0
#Include ..\utils\defaults-gw2.ahk

TradeWindow := Object()
TradeWindow.Discovery := Object
TradeWindow.Production := Object
TradeWindow.Cogwheel := Object

TradeWindow.MainIconImage := "trade-window.png"
; TradeWindow.CraftingComponent := "crafting-component.png"
; TradeWindow.CogWheel := "cogwheel.png"

FindWhereIsEverything() {
    ImageSearch(&xout, &yout, 0, 0, A_ScreenHeight, A_ScreenWidth, TradeWindow.MainIconImage)
    TradeWindow.MainIconCoords := [xout, yout]
    TradeWindow.SearchField := [xout + 65, yout + 62]
    TradeWindow.Discovery.Tab := [xout + 16, yout + 81]		 ; discovery
    TradeWindow.Production.Tab := [xout + 16, yout + 129]		 ; production;
    TradeWindow.Cogwheel.Button := [xout + 291, yout + 65]		 ; cogwheel
    TradeWindow.Cogwheel.CollapseAll := [xout + 332, yout + 85]		 ; collapse all
    TradeWindow.craftingComponent := [xout + 112, yout + 129]		 ; supposedly collapsed “crafting component”
    TradeWindow.firstItemUnderCraftComp := [xout + 96, yout + 156]		 ; first item in there

}

FindWhereIsEverything()

; ImageSearch(&xout, &yout, 0, 0, A_ScreenHeight, A_ScreenWidth, TradeWindow.MainIconImage)

MouseMove TradeWindow.MainIconCoords[1], TradeWindow.MainIconCoords[2]

; Click X := 557, Y := 294 ; in discovery top item
; Click X := 1431, Y := 191 ; in discovery X to close
; Click X := 1075, Y := 835 ; in discovery Craft
; Click X := 1041, Y := 737 ; in production Craft

Click X := 469, Y := 178 ; 
w8