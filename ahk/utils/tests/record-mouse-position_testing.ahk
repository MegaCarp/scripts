#Requires AutoHotkey v2.0
#Include ..\record-mouse-position.ahk

; RecordMousePosition("Click",, 'No')

Test_RecordMousePosition()

Test_RecordMousePosition() {

    ; set the stage
    preTestClipboard := A_Clipboard
    BlockInput 'MouseMove'
    SetTimer EmergencyUnblockMouse, -3000
    MouseGetPos &xout, &yout

    RecordMouseTester('', "Click X := " xout ", Y := " yout) ; default

    RecordMouseTester('Click', "Click X := " xout ", Y := " yout) ; same as default

    RecordMouseTester("Coords", xout ", " yout)

    RecordMouseTester('Relative Coordinates', xout yout, [xout, yout]) ; relative coords

    ; cleanup
    EmergencyUnblockMouse
    SetTimer EmergencyUnblockMouse, 0
    A_Clipboard := preTestClipboard

    RecordMouseTester(Mode, ExpectedOutput, CoordsArray := [0, 0]) {
        RecordMousePosition(Mode, CoordsArray, 'No')
        if Mode = '' {
            Mode := 'Default'
        }
        TestOutput("RecordMousePosition `"" Mode "`" mode", A_Clipboard, ExpectedOutput)
        SetTimer EmergencyUnblockMouse, -3000
    }

    EmergencyUnblockMouse() {
        BlockInput 'MouseMoveOff'
    }

}
