#Requires AutoHotkey v2.0
#HotIf WinActive("ahk_exe Gw2-64.exe") or WinActive("ahk_exe Blish\ HUD.exe")
#Include ..\..\utils\defaults-gw2.ahk

;;;;
Click X := 630, Y := 1000 ; open gear
w8
Click X := 599, Y := 954 ; swap to gear #2
Click X := 640, Y := 924 ; build 3
Send "{Enter}"
w8
Send "/g2 "
w8
Send "preQr[&DQcXHi06KC9tAW0BtgG2AX8BgAHPEoMBvAG8AQAAAAAAAAAAAAAAAAAAAAADWQBWAFcAAA==]." A_Clipboard ; grab previously saved template from cliboard - prepend it with the precast template
w8
Send "{Enter}"
w8
Click(Button := 'R', X := 219, Y := 996) ; right click on pasted template
w8
MouseMove X := 233, Y := 1049 ; open where to paste template picker
w8
MouseMove X := 431, Y := 1053 ; move to not close the template picker
w8
Click X := 414, Y := 1020 ; paste to template 3
w8
Click X := 979, Y := 593 ; yes
w8(standardWaitTime + 100)


Click X := 1042, Y := 1027 ; do heal for regen for conc
Sleep 2300
Click X := 888, Y := 1033 ; do weapon 5
Click X := 834, Y := 1036 ; do weapon 4
Sleep 250
Send "{Ctrl down}{Alt Down}{Shift down}={Ctrl up}{Alt up}{Shift up}"
Click X := 1202, Y := 1037 ; do uti 3
Sleep 750
Click X := 888, Y := 1033 ; do weapon 5
Sleep 700
Click X := 880, Y := 964 ; do continuum split
Send "w" ; do uti 2
Click X := 1253, Y := 1034 ; do elite
Click X := 695, Y := 973 ; do f1
Sleep 175
Click X := 739, Y := 962 ; do f2
Sleep 175
Click X := 777, Y := 970 ; do f3
Sleep 175
Click X := 820, Y := 966 ; do f4
w8
Click X := 880, Y := 964 ; do continuum split
Sleep 175
Click X := 1253, Y := 1034 ; do elite
Click X := 695, Y := 973 ; do f1
w8
Click X := 1093, Y := 1035 ; do uti 1
Sleep 200
Click X := 1153, Y := 1033 ; do uti 2
Click X := 888, Y := 1033 ; do weapon 5
Click X := 739, Y := 962 ; do f2
Sleep 200
Click X := 777, Y := 970 ; do f3
Sleep 200
Click X := 820, Y := 966 ; do f4
Click X := 1153, Y := 1033 ; do uti 2
Sleep 200

Click X := 1306, Y := 760 ; grab singularity
w8

;; prepare to replace the stored template back
Click(Button := 'R', X := 335, Y := 999) ; right click on "." template
w8
MouseMove X := 372, Y := 1051 ; open where to paste template picker
w8
MouseMove X := 560, Y := 1022 ; move mouse to template 3