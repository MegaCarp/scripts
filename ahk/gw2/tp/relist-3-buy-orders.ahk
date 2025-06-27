#Requires AutoHotkey v2.0
#SingleInstance Force

FromTransactionsSelectTop3Items() {
    for id, value IN [418, 481, 538] {
        loop 2 {
            Click X := 1361, Y := value ; open an item to sell
            w8 100
        }
    }
}

FindTPIcon(&OutCoords) {
    ImageSearch &outx, &outy, 0, 0, A_ScreenWidth, A_ScreenHeight, "C:\Users\stash\Documents\scripts\ahk\gw2\tp\tp.png"
    OutCoords := [outx, outy]
}

; ; GoToGw2
; FromTransactionsSelectTop3Items() {
;     for id, value IN [418, 481, 538] {
;         loop 2 {
;             Click X := 1361, Y := value ; open an item to sell
;             w8 100
;         }
;     }
; }

FromTransactionsCancelTop3Items() {
    loop 3 {
        Click X := 1361, Y := 433 ; open an item to sell
        w8 400
        Click X := 1361, Y := 433 ; open an item to sell
        w8 400
    }
}

SelectOneOutOf3RecentlyViewed(Number123) {
    Order := [748, 820, 877]
    Click X := 968, Y := Order[Number123]
}

Gw2Relist3BuyOrders() {
    loop 3 {
        Click X := 854, Y := 714 ; bottom buyer long name
        w8 500
        Click X := 871, Y := 691 ; bottom buyer short name
        w8 500
        MouseMove X := 859, Y := 700 ; mousemove on how much to buy long name
        loop 10 {
            Click 'WheelDown'
            w8 1
        }
        MouseMove X := 850, Y := 700 ; mousemove on how much to buy short name
        loop 10 {
            Click 'WheelDown'
            w8 1
        }
        MouseMove X := 872, Y := 573 ; buy button
        w8 500
        ; Click
        w8 500
        Click X := 1361, Y := 437 ; click off an item
        w8 300
    }
}
