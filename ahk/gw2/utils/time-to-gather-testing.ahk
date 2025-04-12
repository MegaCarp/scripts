#Requires AutoHotkey v2.0
#Include time-to-gather.ahk

; map of the modes has a map with keys being mode names.
; each mode has a array of synonyms, which work and variable input when setting the mode.
; each mode also has an expected output - this is the string that is returned when running the function non-interactively

Map_Modes := Map()

Map_Modes["Rocks"] := Map("Synonyms", Array(), "ExpectedOutput", '', "GatherTime", '')
Map_Modes["Lumber"] := Map("Synonyms", Array(), "ExpectedOutput", '', "GatherTime", '')
Map_Modes["Bush"] := Map("Synonyms", Array(), "ExpectedOutput", '', "GatherTime", '')

Map_Modes["Rocks"]["Synonyms"] := ["Rocks", "R", "1"]
Map_Modes["Rocks"]["GatherTime"] := [, , 4550]

Map_Modes["Lumber"]["Synonyms"] := ["Lumber", "L", "2"]
Map_Modes["Lumber"]["GatherTime"] := [, , 4760]

Map_Modes["Bush"]["Synonyms"] := ["Bush", "B", "3"]
Map_Modes["Bush"]["GatherTime"] := [, , 2055]

for MM_id, MM_value IN Map_Modes
    for syn_id, syn_value IN Map_Modes[MM_id]["Synonyms"]
        if Map_Modes[MM_id]["ExpectedOutput"] = '' {
            Map_Modes[MM_id]["ExpectedOutput"] := syn_value
        } else {
            Map_Modes[MM_id]["ExpectedOutput"] := Map_Modes[MM_id]["ExpectedOutput"] ", " syn_value
        }

LoadA_FieldToTheMapOfMaps(FieldName, ArrayOfValues, TheMap) {

    if Type(ArrayOfValues) != "Array" {
        MsgBox "ArrayOfValues parameter must be an Array."
        return "ArrayOfValues parameter must be an Array."
    }

    if Type(TheMap) != "Map" {
        MsgBox "TheMap parameter must be an Map."
        return "TheMap parameter must be an Map."
    }

    for id, value IN TheMap
        TheMap[id][FieldName] := ArrayOfValues[A_Index]

    return TheMap
}

class TestableDataForSwitching {

    __New(ArrayOfArraysOfSynonyms) {
        ; Data[ArrayOfArraysOfSynonyms] {

        if Type(ArrayOfArraysOfSynonyms) != "Array" {
            MsgBox "Parameter must be an Array."
            return "Parameter must be an Array."
        }

        this[.Data] := Map()

        for id, value IN ArrayOfArraysOfSynonyms
            this.Data[value[1]] := Map("Synonyms", value, "ExpectedOutput", '')

        for MM_id, MM_value IN this.Data
            for syn_id, syn_value IN this.Data[MM_id]["Synonyms"]
                if this.Data[MM_id]["ExpectedOutput"] = '' {
                    this.Data[MM_id]["ExpectedOutput"] := syn_value
                } else {
                    this.Data[MM_id]["ExpectedOutput"] := this.Data[MM_id]["ExpectedOutput"] ", " syn_value
                }
    }

}

classedMap := TestableDataForSwitching([
    [1, "one", "I"],
    [2, "two", "II"],
    [3, "three", "III"]
])

for id, value IN classedMap.Data
    MsgBox id A_Space classedMap.Data[id]["Synonyms"][2]

MakeMapOfMapsForTestableFunction(ArrayOfArraysOfSynonyms) {
    if Type(ArrayOfArraysOfSynonyms) != "Array" {
        MsgBox "Parameter must be an Array."
        return "Parameter must be an Array."
    }

    MyMap := Map()

    for id, value IN ArrayOfArraysOfSynonyms
        MyMap[value[1]] := Map("Synonyms", value, "ExpectedOutput", '')

    for MM_id, MM_value IN MyMap
        for syn_id, syn_value IN MyMap[MM_id]["Synonyms"]
            if MyMap[MM_id]["ExpectedOutput"] = '' {
                MyMap[MM_id]["ExpectedOutput"] := syn_value
            } else {
                MyMap[MM_id]["ExpectedOutput"] := MyMap[MM_id]["ExpectedOutput"] ", " syn_value
            }

    return MyMap

}

myMap := MakeMapOfMapsForTestableFunction([
    [1, "one", "I"],
    [2, "two", "II"],
    [3, "three", "III"]])
myMap := LoadA_FieldToTheMapOfMaps("Relative", ["1st", "2nd", "3rd"], myMap)

; for id, value IN myMap
;     MsgBox id A_Space myMap[id]["Synonyms"][2]

myMap := ''
; test for the automated population of the "expected output" field
; for key, value IN Map_Modes
;     MsgBox key A_Space Map_Modes[key]["ExpectedOutput"]

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
