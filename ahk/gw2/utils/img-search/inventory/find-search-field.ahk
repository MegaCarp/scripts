#Requires AutoHotkey v2.0
#Include ..\..\defaults-gw2.ahk

; timeStart := A_TickCount

if ImageSearch(&Found_search_fieldX, &Found_search_fieldY, 0, 0, A_ScreenWidth, A_ScreenHeight,
    "search-field-start.png") {

    ; MsgBox "it took " A_TickCount - timeStart "ms"

    Click Found_search_fieldX + 100, Found_search_fieldY + 90
} else {

    ErrorGui := Gui(, "Couldn't find the image on screen.")
    ErrorGui.Opt("+AlwaysOnTop +Disabled -SysMenu +Owner")
    ErrorGui.AddPicture(, "search-field-start.png")

    ErrorGui.Show("NoActivate w200 x1698")
    Sleep 2000
    ErrorGui.Hide()
    return
}
