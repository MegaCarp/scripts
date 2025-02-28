#Requires AutoHotkey v2.0
#SingleInstance
#Include defaults-global.ahk

toggleNightlight() {
    CoordMode "Mouse", "Screen"
    MouseGetPos &xpos, &ypos ; save current mouse pos
    run "ms-settings:nightlight" ; open the settings window
    WinWait "Settings" ; wait for the window to load
    w8 ; won't work without the delay
    WinActivate "Settings" ; just in case something goes off
    Send "{Shift Down}{Tab}{Tab}{Shift Up}{Space}" ; pick the right button
    WinActivate "Settings"
    Send "{Alt Down}{F4}{Alt Up}" ; close the settings window
    MouseMove xpos, ypos ; restore the mouse position
}
