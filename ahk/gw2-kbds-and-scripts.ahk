#Requires AutoHotkey v2.0
#SingleInstance Force
#Include gw2\utils\defaults-gw2.ahk

#w:: Gw2Launcher

#HotIf WinActive("ahk_exe Gw2-64.exe")

; #Include gw2\tp\forge-fill.ahk

#Include gw2\translit.ahk

standardWaitTime := 100

SetTimer Blish_ShowAndHide, 5000
!Tab:: Case_AltTabbedIntoBlish

; weapon swap
Enter:: Send "{Ctrl down}{Alt Down}{Shift down}={Ctrl up}{Alt up}{Shift up}"

; chat
F6:: Send "{Enter}"

F10:: Run("gw2\paste-to-chat-and-click.ahk")

; F3:: ForgeAndFill()
F9:: Run 'gw2\tp\TP_Utilities.ahk'

; +g:: {

;     releaseInput() {
;         BlockInput 0
;         Send '{Control Up}'
;     }
;     SetTimer releaseInput, -1000
;     BlockInput 1

;     Send '{Control Down}{Alt Down}{Control Down}'

;     MouseGetPos &xout, &yout

;     Send '{Control Down}'
;     w8 100
;     Click 'Right', X := 774, Y := 1033 ; weapon 3
;     w8 100
;     MouseMove xout, yout, 0

;     Send '{Control Up}'
;     BlockInput 0
;     SetTimer releaseInput, 0
; }

; +t:: {

;     releaseInput() {
;         BlockInput 0
;         Send '{Control Up}'
;     }
;     SetTimer releaseInput, -1000
;     BlockInput 1

;     MouseGetPos &xout, &yout

;     Send '{Control Down}'
;     w8 100
;     Click 'Right', X := 834, Y := 1034 ; weapon 4
;     w8 100
;     MouseMove xout, yout, 0

;     Send '{Control Up}'
;     BlockInput 0
;     SetTimer releaseInput, 0
; }

; F2:: Gw2Sell10
; F2:: RunWait("gw2\tp\cancel-ten.ahk")
; F3:: RunWait("gw2\tp\buy-ten.ahk")

; ^g:: tech_TimingGather(1,2)
; +g:: MouseMove X := 848, Y := 676, 0 ; first slot of the inventory ; show me where the first slot is
; ^g:: GatherBountifully
; ^+g:: GatherBountifully(, "Force Prompt")

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

#HotIf
; F6:: Run "gw2\gw2crafts\main.ahk"
; #HotIf WinActive("ahk_exe Gw2-64.exe")
