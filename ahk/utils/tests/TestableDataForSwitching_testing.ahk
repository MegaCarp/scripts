#Requires AutoHotkey v2.0
#Include ..\TestableDataForSwitching.ahk

; map of the modes has a map with keys being mode names.
; each mode has a array of synonyms, which work and variable input when setting the mode.
; each mode also has an expected output - this is the string that is returned when running the function non-interactively
classedMap :=
    classedMap := TestableDataForSwitching([
        [1, "one", "I"],
        [2, "two", "II"],
        [3, "three", "III"]
    ])
; classedMap.LoadA_FieldToTheMapOfMaps("Relative", ["1st", "2nd", "3rd"])

; TODO if there's an integer in Synonyms, then it'll interefere with "index is a synonym" methodology

; MsgBox classedMap.Count

var := [[1, "one", "I"],
; [, "two", "II"], ; TODO this breaks the crab ; tried to test for it
[2, "two", "II"], 
[3, "three", "III"]]


TestableDataForSwitching.TestInput(var) ; silent means good

if ProcessExist("Telegram.exe") {
    ProcessClose "Telegram.exe"

    WaitToLeaveVDI(Actions*) ; at present this is only used after killing an process to relaunch it after leavig VDI but let's add a 
    {

        CheckWhetherActionIsA_Exe(MaybeA_Path) {
            if Type(MaybeA_Path) != "String" 
                return false ; path has to be a string

            if !RegExMatch(MaybeA_Path, "i)\.exe")
                return false ; path doesn't have an .exe

        }
        try {
            if (WinGetProcessName("A") = "Gw2-64.exe") {
                if WinExist("Blish") {
                    WinRestore "Blish"
                    WinActivate "ahk_exe Gw2-64.exe"
                    SetTimer WaitForGw, 0
                } else {
                    try {
                        Run A_MyDocuments "..\games\gw2\blishud\Blish HUD.exe"
                    } catch {
                        Run A_MyDocuments "..\games\gw2\addons\Blish HUD.exe"
                    }
                    SetTimer WaitForGw, 0
                }
            }
        }
    }
}

