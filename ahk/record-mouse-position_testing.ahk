#Requires AutoHotkey v2.0
#Include utils\defaults-global.ahk
#Include record-mouse-position.ahk

testRecorder := RecordMousePosition()
; testRecorder.Click()
testRecorder.RelativeCoords([100, 100])