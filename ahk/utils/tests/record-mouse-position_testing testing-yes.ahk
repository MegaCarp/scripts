#Requires AutoHotkey v2.0
#Include ..\record-mouse-position.ahk

; RecordMousePosition("Click",, 'No')

Test_RecordMousePosition()

Test_RecordMousePosition() {

    RecordMouseTester("Click", '')


    RecordMouseTester(Mode, ExpectedOutput, CoordsArray := [0, 0]) {
        RecordMousePosition(Mode, CoordsArray, 'No')
    }

}
