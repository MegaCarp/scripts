#Requires AutoHotkey v2.0
#Include defaults-global.ahk

TestOutput(WhatAreWeTesting_str, TestedOutput, ExpectedOutput, ErrorOnly := "Yes") {

    returner := ''
    ;;; for GatherBountifully
    ; if Type(TestedOutput) = "Array"    {
    ; returner := TestedOutput[2]
    ; TestedOutput := TestedOutput[1]
    ;;; for GatherBountifully I'm implementing memory of the last usage - i want to restore the memory after last usage, and for that the "return" will have an array - the 1st value will have the output of the test
    ; have the original value being returned by the function - find a use for it

    ; }
    ; return returner

    if TestedOutput = ExpectedOutput {
        if ErrorOnly != "Yes" {
            MsgBox "👌" WhatAreWeTesting_str " working as expected." ; TODO - notification here, TODO logger here
        }
    } else {
        MsgBox "❗Err! " WhatAreWeTesting_str " output differs from the expected!`nOutput:`n`n" TestedOutput ; TODO - notification here, TODO logger here}
        return 1
    }
}

isTrue(TheData) {
    if TheData
        return true
}

TestOutput_fileExist(FileName) {
    if TestOutput('Test for whether' A_Space FileName A_Space 'exists', isTrue(FileExist(FileName)), true)
        return 1
}

; WorkWith_GetUserInput(Input) {
;     Send "^a"
;     w8 100
;     Send Input
;     w8 100
;     Send "{Enter}"
;     w8 100
; }
