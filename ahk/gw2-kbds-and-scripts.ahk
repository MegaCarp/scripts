#Requires AutoHotkey v2.0

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

; special action key
; BackSpace:: Send "{Ctrl down}{Alt Down}{Shift down}-{Ctrl up}{Alt up}{Shift up}"

; F4::Run "gw2\fractals\precast\quick.ahk"

; F4::Run "gw2\fractals\precast\quick-resist.ahk"

; F4::Run "gw2\fractals\precast\alac.ahk"

; F4::Run "gw2\fractals\precast\alac-resist.ahk"

; #HotIf
; F5:: Run "gw2\copy-from-gw2skills.ahk"
; #HotIf WinActive("ahk_exe Gw2-64.exe")
