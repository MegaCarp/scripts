#Requires AutoHotkey v2.0
#Include defaults-global.ahk

; map of the modes has a map with keys being mode names.
; each mode has a array of synonyms, which work and variable input when setting the mode.
; each mode also has an expected output - this is the string that is returned when running the function non-interactively

;;; TODO
; Synonyms can be simply the first array's value:
; let's say the array is [["Masterwork", "M", "3"], etc]]

; you can just use the "Masterwork" at the start and produce the rest automatically from that
; the default __New therefore should do that, and have a separate class.method for making synonyms out of [[1, "one", "I"], etc] arrays

class TestableDataForSwitching {

    TestForMatchAmongSynonyms(Needle, OutputFieldName := 'Payload', IsThisA_Test := "No") {
        for id, top_level_field_name IN this[]
            for id, value IN this[top_level_field_name]["Synonyms"]
                if RegExMatch(value, "i)^" Needle "$") != 0 {
                    if IsThisA_Test = "No" {
                        return this[top_level_field_name][OutputFieldName]
                    } else return this[top_level_field_name]["ExpectedOutput"]
                }
    }

    GiveMeA_ListOfAllSynonyms(ToClipboard := 'No') {
        MsgBox 'TODO'
    }

    __New(ArrayOfArraysOfSynonyms) {

        if Type(ArrayOfArraysOfSynonyms) != "Array" {
            MsgBox "Parameter must be an Array - deleting object."
            this.__Delete()
        }

        this[] := Map()

        for id, value IN ArrayOfArraysOfSynonyms {
            TheListOfSynonyms := []
            if A_Index < 3 {
            if TheListOfSynonyms = [] {
                TheListOfSynonyms.Push value
            } else {
                TheListOfSynonyms.Push SubStr(value, 1, 1)
            } } else TheListOfSynonyms.Push A_Index
        }

        for id, value IN ArrayOfArraysOfSynonyms
            this[value[1]] := Map("Synonyms", value, "ExpectedOutput", '')

        for MM_id, MM_value IN this[]
            for syn_id, syn_value IN this[MM_id]["Synonyms"]
                if this[MM_id]["ExpectedOutput"] = '' {
                    this[MM_id]["ExpectedOutput"] := syn_value
                } else {
                    this[MM_id]["ExpectedOutput"] := this[MM_id]["ExpectedOutput"] ", " syn_value
                }
    }

    LoadA_FieldToTheMapOfMaps(ArrayOfValues, FieldName := 'Payload') {

        if Type(ArrayOfValues) != "Array" {
            MsgBox "ArrayOfValues parameter must be an Array."
            return "ArrayOfValues parameter must be an Array."
        }

        for id, value IN this[]
            this[id][FieldName] := ArrayOfValues[A_Index]
    }

}
