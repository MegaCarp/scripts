#Requires AutoHotkey v2.0
#SingleInstance Force
#Include defaults-gw2.ahk

gw_arena_net_directory_addons := 'C:\games\GuildWars2-arenanet\addons'
gw_epic_directory_addons := 'C:\games\GuildWars2\addons'

if TestOutput_fileExist(gw_arena_net_directory_addons)
    ExitApp ;!!

TestOutput_fileExist(gw_epic_directory_addons) ;; doesn't have to exist


; Define the paths for the existing file and the new hard link
existingFile := A_Desktop "\original_file.txt"
hardLink := A_Desktop "\hard_link_to_file.txt"

; Create a sample original file if it doesn't exist
if (!FileExist(existingFile)) {
    FileAppend "This is the content of the original file.", existingFile
}

; Create the hard link using DllCall
; DllCall("CreateHardLink", Str, lpFileName, Str, lpExistingFileName, Ptr, lpSecurityAttributes)
; lpFileName: The path to the new hard link
; lpExistingFileName: The path to the existing file
; lpSecurityAttributes: Optional security attributes (set to 0 for default)
success := DllCall("CreateHardLink", "Str", hardLink, "Str", existingFile, "Ptr", 0)

; Check if the hard link creation was successful
if (success) {
    MsgBox "Hard link created successfully: " hardLink
} else {
    MsgBox "Failed to create hard link. Error: " A_LastError
}

; loop files FilePattern, 'FDR'
; MoveLocalDat(Name) {

;     ;;;; turn this into a battery of tests with C:\Users\stash\Documents\scripts\ahk\utils\InputChecker.ahk
;     SourceMainAddonsFolder := gw_arena_net_directory '\addons'
;     if !FileExist(SourceMainAddonsFolder) {
;         MsgBox "SourceLocalDat " SourceMainAddonsFolder " does not exist! Exiting."
;         return
;     }

;     SourceLocalDat := "C:\Users\" A_UserName "\AppData\Roaming\Guild Wars 2\" Name ".dat"
;     if !FileExist(SourceLocalDat) {
;         MsgBox "SourceLocalDat " SourceLocalDat " does not exist! Exiting."
;         return
;     }

;     TargetLocalDat := "C:\Users\" A_UserName "\AppData\Roaming\Guild Wars 2\Local.dat"
;     if !FileExist(TargetLocalDat) {
;         MsgBox "TargetLocalDat " TargetLocalDat " does not exist - continue regardless."
;     }

;     SourceBlishTodo := "C:\Users\" A_UserName "\Documents\Guild Wars 2\addons\blishhud\todos - " Name
;     if !FileExist(SourceBlishTodo) {
;         MsgBox "SourceBlishTodo " SourceBlishTodo " does not exist! Exiting."
;         return
;     }

;     ; "C:\Users\stash\Documents\Guild Wars 2\addons\blishhud\events\event_states.json"
;     ; Event states for Blish Event Timers
;     TargetBlishEventStates := "C:\Users\" A_UserName "\Documents\Guild Wars 2\addons\blishhud\todos"
;     if !FileExist(TargetBlishEventStates) {
;         MsgBox "TargetBlishEventStates " TargetBlishEventStates " does not exist! Exiting."
;         return
;     }

;     SourceBlishEventStates := "C:\Users\" A_UserName "\Documents\Guild Wars 2\addons\blishhud\todos - " Name
;     if !FileExist(SourceBlishEventStates) {
;         MsgBox "SourceBlishEventStates " SourceBlishEventStates " does not exist! Exiting."
;         return
;     }

;     TargetBlishTodo := "C:\Users\" A_UserName "\Documents\Guild Wars 2\addons\blishhud\todos"
;     if !FileExist(TargetBlishTodo) {
;         MsgBox "TargetBlishTodo " TargetBlishTodo " does not exist! Exiting."
;         return
;     }

;     KillGW2
;     ;;;;;;;;;;;;;;;

;     loop files SourceBlishTodo '\*' {
;         try FileRecycle(TargetBlishTodo '\' A_LoopFileName)
;         catch {
;             SplitPath SourceBlishTodo, , &OutDir
;             MsgBox 'a todo has been deleted, moving it to trash`nFrom: ' A_LoopFilePath '`nTo: ' OutDir '\todo-trashed\' A_LoopFileName
;             FileMove A_LoopFilePath, OutDir '\todo-trashed\' A_LoopFileName, 1
;         }
;     }

;     FileCopy TargetBlishTodo '\*.*', SourceBlishTodo '\*.*'

;     scriptFileName := A_WorkingDir '\hardlinker-script.ps1'
;     try FileRecycle(scriptFileName)

;     ; Local.dat
;     ToWriteToScript := 'New-Item -ItemType HardLink -Target `"' SourceLocalDat '`" -Path `"' TargetLocalDat '`"`n'

;     loop files SourceBlishTodo '\*'
;         ToWriteToScript := ToWriteToScript 'New-Item -ItemType HardLink -Target `"' A_LoopFilePath '`" -Path `"' TargetBlishTodo '\' A_LoopFileName '`"`n'

;     FileAppend ToWriteToScript, scriptFileName
;     FileRecycle TargetLocalDat

;     ;;;;;;;;;;;;;;;;

;     ; RunWait 'pwsh.exe -File `"' scriptFileName '`"'
;     RunWait 'pwsh.exe -WindowStyle Hidden -File `"' scriptFileName '`"'
;     ;;;;;;;;;;;;;;;;

; }

;;;;;;;;;;;

;     $sourcePath = "C:\Users\" + $env: USERNAME + "\Documents\Guild Wars 2\InputBinds"

;     $fileNames = (Get - ChildItem - Path$sourcePath - File).Name

; foreach ($xml in $fileNames) {
;     $whereToPutLink = "C:\Users\stash\Documents\scripts\ahk\gw2\InputBinds\" + $xml
;         $LinkFrom = "C:\Users\stash\Documents\Guild Wars 2\InputBinds\" + $xml

;     New - Item - ItemType HardLink - Path$whereToPutLink - Target$LinkFrom
; }
