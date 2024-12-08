#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe Gw2-64.exe") or WinActive("ahk_exe Blish\ HUD.exe")

^F11::
{
    MouseGetPos &xpos, &ypos
    MouseClickDrag , xpos, ypos, 962, 9 
}
F20::Click , 962, 9
; Screen:	962, 9 # move tp window into the starting position
; Screen:	0, 183 # auc tab
; Screen:	855, 97 # my transactions
; Screen:	144, 251 # buying
; Screen:	835, 203 # sort by earliest
; Screen:	824, 244 # press top level item / click off the item
; Screen:	892, 249 # press cancel