#Requires AutoHotkey v2.0
#SingleInstance Force

#Include TransparentGui.ahk

Esc:: ExitApp

test := TransparentGui(, 'ahk_exe Code.exe', 1)
test.TestOut

SetTimer terminateGui, -12000

terminateGui() {
    test.Destroy
}
