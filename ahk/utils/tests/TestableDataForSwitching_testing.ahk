#Requires AutoHotkey v2.0
#Include ..\TestableDataForSwitching.ahk

; map of the modes has a map with keys being mode names.
; each mode has a array of synonyms, which work and variable input when setting the mode.
; each mode also has an expected output - this is the string that is returned when running the function non-interactively

classedMap := TestableDataForSwitching([
    [1, "one", "I"],
    [2, "two", "II"],
    [3, "three", "III"]
])
; classedMap.LoadA_FieldToTheMapOfMaps("Relative", ["1st", "2nd", "3rd"])

returner := Array()
for id, value IN classedMap {

    top_level_index := A_Index
    returner.Push id

    for id, value IN value {
        returner[top_level_index] .= "`n`t" id A_Tab

        if Type(value) = "String" {
            returner[top_level_index] .= value
        } else {
            returner[top_level_index] .= "`n`t`t`t"
            for id, value IN value
                returner[top_level_index] .= value
        }
    }
}
for id, value IN returner
MsgBox value
returner := ''