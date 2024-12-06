#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe Gw2-64.exe") or WinActive("ahk_exe Blish\ HUD.exe")

F10::
{
    Send "{Enter}"
    Sleep 20
    Send "/w Captatrix"
    Sleep 20
    Send "{Tab}" 
    Sleep 20
    SendEvent "^v"
    Sleep 20
    Send "{Enter}"
}