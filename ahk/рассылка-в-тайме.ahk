#Requires AutoHotkey v2.0
#SingleInstance Force
#Include utils\defaults-global.ahk
; requirements:
; opened excel with a list of cells filled with logins
; opened word and text to copy already selected
; opened TiMe with not opened direct message recipient search

WinActivate "Excel"
w8(300)
Send "{Down}"
w8(300)
Send "^c"
w8
WinActivate "TiMe"
w8
Send "^+k" ; new direct message
w8(400)
Send "^v"
w8(1100) ; wait for it to load the contact
Click X := 787, Y := 378 ; first item
w8
Click X := 1188, Y := 852 ; "write" button
; MouseMove X := 1188, Y := 852 ; "write" button
w8(1000)
WinActivate "Word"
w8
send "^c"
w8
WinActivate "TiMe"
w8
Send "^v"