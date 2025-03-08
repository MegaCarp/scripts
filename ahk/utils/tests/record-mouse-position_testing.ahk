#Requires AutoHotkey v2.0
#Include ..\record-mouse-position.ahk

testRecorder := RecordMousePosition()
; testRecorder.Click()
testRecorder.RelativeCoords([1000, 1000])