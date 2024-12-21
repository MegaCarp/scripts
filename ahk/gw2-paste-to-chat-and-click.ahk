#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe Gw2-64.exe") or WinActive("ahk_exe Blish\ HUD.exe")

#Include lib\Base64toHex.ahk ; A_Clipboard := BinaryToHex(Base64ToBinary("AgGqtgAA")) ; 0201AAB60000

F10::
{
    Send "{Enter}"
    Sleep 200
    Send "/w Captatrix"
    Sleep 200
    Send "{Tab}" 
    Sleep 200
    SendEvent "^v"
    Sleep 200
    Send "{Enter}"
}