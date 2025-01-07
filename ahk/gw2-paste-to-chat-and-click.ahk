#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe Gw2-64.exe") or WinActive("ahk_exe Blish\ HUD.exe")

F10::
{
    Send "{Enter}"
    Sleep 200
    Send "/w Captatrix"
    Sleep 200
    Send "{Tab}" 
    Sleep 200
    ; SendEvent "^v"
    Send A_Clipboard
    Sleep 200
    Send "{Enter}"
}