#Requires AutoHotkey v2.0
#Include time-to-gather.ahk

;;; testing workflow
; store the memory of the last usage

; reset the memory by prompting for a new value
; fill the value automatically
; test then whether the memory of the value works by running it with empty inputs
; then test whether by evoking any other function i can expect it succesfully swap to new mode
; then test whether the last call with a random input has also succesfully changed the memory as well by doing another testrun with empty inputs

; run that way through all the modes implemented

; restore the memory of the last usage
;;;

;;; suspending testing while testing out the paradigm of storing data in a map of maps
; WrapperForTheTester_GatherBountifully

; purpose: the function has memory of the last usage - i want to restore the memory to the original state after the battery of tests is done running
; I also have no generalized use for this mess of technical functions and don't want them to needlessly pollute the runtime (is that the right way to put it?..), so let's have them as nested functions
WrapperForTheTester_GatherBountifully() {
    StoredPreTestModeValue := Test_GatherBountifully("Default", "Testing default")
    Test_GatherBountifully(1, "Rocks or 1 or R")

    Test_GatherBountifully(2, "Lumber or L or 2", "GetInput")

    ; TestOutput("GatherBountifully switch statement default mode", GatherBountifully(, , 1), "default or Rocks or 1 or R")

    ; TestOutput("GatherBountifully switch statement `"Rocks`" mode", GatherBountifully("Rocks", , 1),
    ; "default or Rocks or 1 or R")
    ; TestOutput("GatherBountifully switch statement `"R`" mode", GatherBountifully("R", , 1), "default or Rocks or 1 or R")
    ; TestOutput("GatherBountifully switch statement `"1`" mode", GatherBountifully(1, , 1), "default or Rocks or 1 or R")

    ; TestOutput("GatherBountifully switch statement mode `"Lumber`"", GatherBountifully(2, , 1), "Lumber or L or 2")
    ; TestOutput("GatherBountifully switch statement mode `"Bush`"", GatherBountifully(3, , 1), "Bush or B or 3")
    ; TestOutput("GatherBountifully switch statement invalid mode", GatherBountifully(324141, , 1), "Incorrect Mode")
    RestoreTheOriginalModeMemoryValue(StoredPreTestModeValue,)

    RestoreTheOriginalModeMemoryValue(StoredPreTestModeValue) {
        GatherBountifully(StoredPreTestModeValue, , "Noninteractive")
    }

    Test_GatherBountifully(Mode, ExpectedOutput, InputOrSansInput := "Skip GetUserInput") {

        if InputOrSansInput = "Skip GetUserInput" AND Mode != "Default" {
            StoredPreTestModeValue := TestOutput("GatherBountifully switch statement mode " Mode " with NO InputBox",
                GatherBountifully(Mode, ,
                    "NonInteractively"),
                ExpectedOutput)

            TestOutput("Testing whether the switch statement will remember mode " Mode " with NO InputBox",
                GatherBountifully(, ,
                    "NonInteractively"),
                ExpectedOutput)
        } else {

            DoTheTestWithAutomatedInputBox(Mode, ExpectedOutput)

            DoTheTestWithAutomatedInputBox(Mode, ExpectedOutput) {
                Specialized_WorkWith_GetUserInput() {
                    WorkWith_GetUserInput(Mode)
                }

                if Mode != "Default" {
                    SetTimer Specialized_WorkWith_GetUserInput, -100
                    TestOutput("GatherBountifully switch statement " Mode " WITH InputBox INCLUDED", GatherBountifully(,
                        "ForcePrompt", "NonInteractively"), ExpectedOutput) ; TODO think about ForcePrompt

                    TestOutput("Testing whether the switch statement will remember mode " Mode " WITH InputBox INCLUDED",
                        GatherBountifully(,
                            , "NonInteractively"), ExpectedOutput) ; TODO think about ForcePrompt

                } else {

                    MsgBox "Testing using switch with the prompt following leaving Mode as default, by skipping it" ; TODO change into a notification
                    DoTheTestWithAutomatedInputBox(1, "default or Rocks or 1 or R")
                    DoTheTestWithAutomatedInputBox(2, "Lumber or L or 2")
                    DoTheTestWithAutomatedInputBox(3, "Bush or B or 3")
                    DoTheTestWithAutomatedInputBox("invalid entry", "Incorrect Mode")
                    DoTheTestWithAutomatedInputBox("", "Incorrect Mode")

                }
            }
        }

        return StoredPreTestModeValue
    }

}
