#Requires AutoHotkey v2.0
#SingleInstance Force
#Include utils\defaults-gw2.ahk

#Include ..\lib\lib_base64ToBinToHex.ahk

GoToGw2
            Click X := 230, Y := 1010 ; LButton click in chat on the link following the nickname in the last
            w8(standardWaitTime + 900)
            Click X := 962, Y := 541 ; wait for map to show the wp then double click it
            Click
