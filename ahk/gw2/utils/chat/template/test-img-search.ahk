#Requires AutoHotkey v2.0

#Include ..\..\defaults-gw2.ahk

    timeStart := A_TickCount

if ImageSearch(&Found_search_fieldX, &Found_search_fieldY, 0, 0, A_ScreenWidth, A_ScreenHeight,
    "search-field-start.png") {

        ticksTimer(1, timeStart) ; add value to debug to get a notification for this

    Click Found_search_fieldX + 100, Found_search_fieldY + 90
} else {

   
}
