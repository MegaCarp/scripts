#Requires AutoHotkey v2.0
#SingleInstance Force

#Include TransparentGui.ahk

test := TransparentGui()
test.TestOut

SetTimer terminateGui, -10000

terminateGui() {
    test.Destroy
}