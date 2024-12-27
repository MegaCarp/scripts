#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe Gw2-64.exe") or WinActive("ahk_exe Blish\ HUD.exe")
Enter::Send "{Ctrl down}{Alt Down}{Shift down}={Ctrl up}{Alt up}{Shift up}"
F6::Send "{Enter}"

; This script will perform a dodge jump when Mouse Button 4 is pressed
r::
   { 
    Send "{Space}" ; jump
    Sleep 0 ; Adjust the delay as needed
    Send "{XButton1}" ; Send the dodge command (Mouse Button 4)
    Send "{Space}" ; jump
    Send "{XButton1}" ; Send the dodge command (Mouse Button 4)
    Send "{Space}" ; jump
    Send "{XButton1}" ; Send the dodge command (Mouse Button 4)
   }

BackSpace::Send "{Ctrl down}{Alt Down}{Shift down}-{Ctrl up}{Alt up}{Shift up}"