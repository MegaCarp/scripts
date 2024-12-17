#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe Gw2-64.exe") or WinActive("ahk_exe Blish\ HUD.exe")

#Include lib\bin2hex.ahk ; MsgBox Format('0x{:X}', bin2dec('1111100110111110'))
#Include lib\Base64ToString.ahk ;

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