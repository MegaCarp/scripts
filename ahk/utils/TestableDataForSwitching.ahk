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

class TestableDataForSwitching extends Map {

    static Field1 := "Synonyms"
    static Field2 := "ExpectedOutput"
    Length := 0

    __New(ArrayOfArrays_Synonyms, LoadingFields*) {

        if Type(ArrayOfArrays_Synonyms) != "Array" {
            MsgBox "Parameter must be an Array - deleting object."
            this.__Delete()
        }

        ; for id, value IN ArrayOfArrays_Synonyms {
        ;     TheListOfSynonyms := []
        ;     if A_Index < 3 {
        ;     if TheListOfSynonyms = [] {
        ;         TheListOfSynonyms.Push value
        ;     } else {
        ;         TheListOfSynonyms.Push SubStr(value, 1, 1)
        ;     } } else TheListOfSynonyms.Push A_Index
        ; }

        for id, value IN ArrayOfArrays_Synonyms {
            this[value[1]] := Map(TestableDataForSwitching.Field1, value, TestableDataForSwitching.Field2, '')
            this.Length += 1
        }
        for MM_id, MM_value IN this
            for syn_id, syn_value IN this[MM_id][TestableDataForSwitching.Field1]
                if this[MM_id][TestableDataForSwitching.Field2] = '' {
                    this[MM_id][TestableDataForSwitching.Field2] := syn_value
                } else {
                    this[MM_id][TestableDataForSwitching.Field2] := this[MM_id][TestableDataForSwitching.Field2] ", " syn_value
                }

        if LoadingFields {
            for id, value IN LoadingFields
                this.LoadA_Field(value[2], value[1])
        }

    }

    LoadA_Field(Array, FieldName := 'Payload', Force := 'No') {

        if Type(Array) != "Array" {
            MsgBox "Array parameter must be an Array."
            return "Array parameter must be an Array."
        }

        if Array.Length != this.Length {
            MsgBox "There's a difference in top level fields quantity and the quantity values given.`n`nData fields number in: " this
                .Length "`nTried to load an array of: " Array.Length
            return "Length difference. Should be: " this.Length ", and given: " Array.Length
        }

        if Force = 'No' {
            for id, value IN this
                for id, value IN this[id] {
                    if FieldName = id {
                        "There is already a " FieldName " field, aborting."
                        return "There is already a " FieldName " field, aborting."
                    }
                }
        }
        
        for id, value IN this[]
            this[id][FieldName] := Array[A_Index]

    }

    TestForMatchAmongSynonyms(Needle, OutputFieldName := 'Payload', IsThisA_Test := "No") {
        for id, top_level_field_name IN this
            for id, value IN this[top_level_field_name][TestableDataForSwitching.Field1]
                if RegExMatch(value, "i)^" Needle "$") != 0 {
                    if IsThisA_Test = "No" {
                        return this[top_level_field_name][OutputFieldName]
                    } else return this[top_level_field_name][TestableDataForSwitching.Field2]
                }
    }

    PrintOutTheHierarchy(IsThisA_Test := "No") {
        returner := Array()
        for id, value IN classedMap {

            top_level_index := A_Index
            returner.Push id "`tv v v"

            for id, value IN value {
                returner[top_level_index] .= "`n>>>`t" id

                if Type(value) = "String" {
                    returner[top_level_index] .= A_Space ">>>" A_Space "`"" value "`""
                } else {
                    returner[top_level_index] .= "`tv v v`n`t`t>>>`t"
                    for id, value IN value
                        returner[top_level_index] .= value
                }
            }
        }

        if IsThisA_Test = 'No' {
            for id, value IN returner
                MsgBox value ; TODO notification
        } else {
            concatenation := ''
            for id, value IN returner
                concatenation .= "`n" value

            return concatenation
        }
    }

    GiveMeA_ListOfAllSynonyms(ToClipboard := 'No') {
        returner := ''
        for top_level_id, top_level_value IN this {
            if ToClipboard = 'No'
                returner .= top_level_id ":" A_Tab top_level_value[TestableDataForSwitching.Field2] '`n'
        } else A_Clipboard top_level_value[TestableDataForSwitching.Field2]

        if ToClipboard = 'No'
            MsgBox returner  ; TODO notification
    }

}
