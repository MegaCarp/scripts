#Requires AutoHotkey v2.0
#SingleInstance Force

Esc:: ExitApp

enter:: {
    loop 250 { 
        Click X := 575, Y := 313,,2 ; slot1
        sleep 100
        Click X := 651, Y := 326,,2 ; slot2
        sleep 100
        Click X := 695, Y := 319,,2 ; slot3
        sleep 100
        Click X := 757, Y := 309,,2 ; slot4
        sleep 100
        Click X := 1132, Y := 690 ; forge
        sleep 100
        send "{LControl}"
        sleep 100
    }
}
