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

; class TestableDataForSwitching extends Map {

;     static Field1 := "Synonyms"
;     static Field2 := "ExpectedOutput"

;     PreferableInstantiationMethod() {
;         ; Given "Lumber" produce "Lumber, L, 1"

;         var := [["Lumber"], ["Rocks"]]

;         TestForDefaultMethodViability(ArrayOfArrays_Synonyms) ; it has to be a string - let's start there
;         {
;             for id, value IN ArrayOfArrays_Synonyms
;                 for id, value IN value[1] {
;                     if Type(value) != "String"
;                         return true
;                 }
;         }

;         if !TestForDefaultMethodViability(ArrayOfArrays) {
;             for id, value IN ArrayOfArrays
;                 MsgBox "TestForViability passed"

;         } else MsgBox "TestForViability FAILED"

;     }

;     static TestInput(ArrayOfArrays_Synonyms) ; if the test returns nothing - it passed
;     {

;         for id_top, value IN ArrayOfArrays_Synonyms ; grab every value from the ArrOfArr
;             for id_bot, value IN value {
;                 if !value {
;                     str := "ArrayOfArrays_Synonyms has an empty value.`nCoords: [" id_top "][" id_bot "]"
;                     MsgBox str
;                     return str
;                 }
;             }

;         if Type(ArrayOfArrays_Synonyms) != "Array" {
;             str := "ArrayOfArrays_Synonyms has to be an Array"
;             MsgBox str
;             return str
;         }

;         for id, value IN ArrayOfArrays_Synonyms
;             if Type(value) != "Array" {
;                 str := "Index " id " of the ArrayOfArrays_Synonyms is not an Array"
;                 MsgBox str
;                 return str
;             }

;         TestA_SynonymAgainstEveryOtherSynonym(A_SynonymOrA_Array, MaybeTestAgainstSomethingElse := A_SynonymOrA_Array) {

;             if Type(A_SynonymOrA_Array) != "Array" AND Type(MaybeTestAgainstSomethingElse) != "Array" {
;                 str := "The starting variables are literally the same thing - and they're not Arrays."
;                 MsgBox str
;                 return str
;             }

;             ArrayVsArray := [A_SynonymOrA_Array, MaybeTestAgainstSomethingElse]

;             if Type(ArrayVsArray[1])
;                 if !from_value {
;                     for id_from_top, value IN ArrayOfArrays_Synonyms ; grab every value from who we are testing
;                         for id_from_inner, from_value IN value
;                 }
;             for id_to_top, value IN ArrayOfArrays_Synonyms ; grab everything from the target
;                 for id_to_inner, to_value IN value {
;                     if id_from_top id_from_inner = id_to_top id_to_inner { ; if the coords are the same - skip
;                         continue
;                     } else {
;                     }
;                 }

;             RunComparison() {
;                 if from_value = to_value {
;                     str := "There is a repeating value in the ArrayOfArrays_Synonyms`n`nCoords 1: [" id_from_top "][" id_from_inner "]`nCoords 2: [" id_to_top "][" id_to_inner "]`nThe value: " from_value

;                     MsgBox str
;                     return str
;                 }
;             }

;         }
;         ; check everything against everything, with the obvious exception being itself

;     }

;     __New(ArrayOfArrays_Synonyms, LoadingFields*) {

;         if TestableDataForSwitching.TestInput(ArrayOfArrays_Synonyms) {
;             this := ''
;         }
;         ; for id, value IN ArrayOfArrays_Synonyms {
;         ;     TheListOfSynonyms := []
;         ;     if A_Index < 3 {
;         ;     if TheListOfSynonyms = [] {
;         ;         TheListOfSynonyms.Push value
;         ;     } else {
;         ;         TheListOfSynonyms.Push SubStr(value, 1, 1)
;         ;     } } else TheListOfSynonyms.Push A_Index
;         ; }

;         for id, value IN ArrayOfArrays_Synonyms {
;             this[value[1]] := Map(TestableDataForSwitching.Field1, value, TestableDataForSwitching.Field2, '')
;         }
;         for MM_id, MM_value IN this
;             for syn_id, syn_value IN this[MM_id][TestableDataForSwitching.Field1]
;                 if this[MM_id][TestableDataForSwitching.Field2] = '' {
;                     this[MM_id][TestableDataForSwitching.Field2] := syn_value
;                 } else {
;                     this[MM_id][TestableDataForSwitching.Field2] := this[MM_id][TestableDataForSwitching.Field2] ", " syn_value
;                 }

;         ; if LoadingFields {
;         ;     for id, value IN LoadingFields
;         ;         this.LoadA_Field(value[2], value[1]) ; if something failt to load, that's fine
;         ; }

;     }

;     ; LoadA_Field(Array, FieldName := 'Payload', Force := 'No') {

;     ;     if Type(Array) != "Array" {
;     ;         MsgBox "Array parameter must be an Array."
;     ;         return "Array parameter must be an Array."
;     ;     }

;     ;     if Force = 'No' {
;     ;         if Array.Length != this.Count {
;     ;             MsgBox "There's a difference in top level fields quantity and the quantity values given.`n`nData fields number in: " this
;     ;                 .Count "`nTried to load an array of: " Array.Length
;     ;             return "Length difference. Should be: " this.Count ", and given: " Array.Length
;     ;         }

;     ;         for id, value IN this
;     ;             for id, value IN this[id] {
;     ;                 if FieldName = id {
;     ;                     "There is already a " FieldName " field, aborting."
;     ;                     return "There is already a " FieldName " field, aborting."
;     ;                 }
;     ;             }
;     ;     }

;     ;     for id, value IN this[]
;     ;         this[id][FieldName] := Array[A_Index]

;     ; }

;     TestForMatchAmongSynonyms(Needle, OutputFieldName := 'Payload', IsThisA_Test := "No") {
;         for id, top_level_field_name IN this
;             for id, value IN this[top_level_field_name][TestableDataForSwitching.Field1]
;                 if RegExMatch(value, "i)^" Needle "$") != 0 {

;                     if IsThisA_Test = "No" {
;                         return this[top_level_field_name][OutputFieldName]
;                     } else return this[top_level_field_name][TestableDataForSwitching.Field2]
;                 }
;     }

;     PrintOutTheHierarchy(IsThisA_Test := "No") {
;         returner := Array()
;         for id, value IN classedMap {

;             top_level_index := A_Index
;             returner.Push id "`tv v v"

;             for id, value IN value {
;                 returner[top_level_index] .= "`n>>>`t" id

;                 if Type(value) = "String" {
;                     returner[top_level_index] .= A_Space ">>>" A_Space "`"" value "`""
;                 } else {
;                     returner[top_level_index] .= "`tv v v`n`t`t>>>`t"
;                     for id, value IN value
;                         returner[top_level_index] .= value
;                 }
;             }
;         }

;         if IsThisA_Test = 'No' {
;             for id, value IN returner
;                 MsgBox value ; TODO notification
;         } else {
;             concatenation := ''
;             for id, value IN returner
;                 concatenation .= "`n" value

;             return concatenation
;         }
;     }

;     GiveMeA_ListOfAllSynonyms(ToClipboard := 'No') {
;         returner := ''
;         for top_level_id, top_level_value IN this {
;             if ToClipboard = 'No'
;                 returner .= top_level_id ":" A_Tab top_level_value[TestableDataForSwitching.Field2] '`n'
;         } else A_Clipboard top_level_value[TestableDataForSwitching.Field2]

;         if ToClipboard = 'No'
;             MsgBox returner  ; TODO notification
;     }

; }
