#Requires AutoHotkey v2.0

#Include ..\utils\defaults-gw2.ahk

; GoToGw2

Gw2Sell10() {
    loop 3 {
        Click X := 1361, Y := 437 ; open an item to sell
        w8 500
        Click X := 1118, Y := 721 ; bottom seller long name
        w8 500
        Click X := 1094, Y := 682 ; bottom seller short name
        w8 500
        MouseMove X := 859, Y := 442 ; mousemove on how much to sell long name
        loop 20 {
            Click 'WU'
            w8 1
        }
        MouseMove X := 850, Y := 431 ; mousemove on how much to sell short name
        loop 20 {
            Click 'WU'
            w8 1
        }
        ; Send '{Control down}a{Control up}'
        ; Send '^a'
        ; Send '99'
        MouseMove X := 872, Y := 573 ; sell button
        w8 500
        Click
        w8 500
        ; Click X := 872, Y := 573 ; sell button
        ; w8 1000
        Click X := 1361, Y := 437 ; click off an item
        w8 300
    }
}
