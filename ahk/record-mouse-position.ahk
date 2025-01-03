#Requires AutoHotkey v2.0

F12::
{
    MouseGetPos &xpos, &ypos
    A_Clipboard := "X := " xpos ", Y := " ypos
}