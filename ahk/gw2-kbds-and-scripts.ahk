#Requires AutoHotkey v2.0
#SingleInstance Force

#HotIf WinActive("ahk_exe Gw2-64.exe")

#Include gw2\translit.ahk

standardWaitTime := 100

; weapon swap
Enter:: Send "{Ctrl down}{Alt Down}{Shift down}={Ctrl up}{Alt up}{Shift up}"

; chat
F6:: Send "{Enter}"

F10:: Run("gw2\paste-to-chat-and-click.ahk")

; r:: Run "gw2\dodge-jump.ahk"

; t:: Run "gw2\challenge-restart.ahk"

F7:: Run "gw2\fractals\slash-gg.ahk"

 F23:: Send "{Ctrl down}{Alt Down}{Shift down},{Ctrl up}{Alt up}{Shift up}" ; mastery key
 F24:: Send "{Ctrl down}{Alt Down}{Shift down}.{Ctrl up}{Alt up}{Shift up}" ; special action key
 F22:: Send "{Ctrl down}{Alt Down}{Shift down}m{Ctrl up}{Alt up}{Shift up}" ; stow weapon key

; F4::Run "gw2\fractals\precast\quick.ahk"

; F4::Run "gw2\fractals\precast\quick-resist.ahk"

; F4::Run "gw2\fractals\precast\alac.ahk"

; F4::Run "gw2\fractals\precast\alac-resist.ahk"

; #HotIf
; F6:: Run "gw2\gw2crafts\main.ahk"
; #HotIf WinActive("ahk_exe Gw2-64.exe")
