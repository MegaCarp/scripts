#Requires AutoHotkey v2.0
#SingleInstance Force
#Include defaults-gw2.ahk

HardlinkDllAddonsFromMainGW2ToSecondaryFolder('C:\games\GuildWars2-arenanet\addons', 'C:\games\GuildWars2\addons')

; Function to compare two files byte by byte. Returns 0 if same!
TheseAreDifferentFiles(file1Path, file2Path) {
    ; Check if both files exist
    if (!FileExist(file1Path) || !FileExist(file2Path)) {
        return 1 ; One or both files do not exist
    }

    ; Get file sizes
    file1Size := FileGetSize(file1Path)
    file2Size := FileGetSize(file2Path)

    ; If sizes are different, files cannot be the same
    if (file1Size != file2Size) {
        return 1
    }

    ; Open both files for reading
    file1 := FileOpen(file1Path, "r")
    file2 := FileOpen(file2Path, "r")

    ; If files couldn't be opened, return false
    if (!IsObject(file1) || !IsObject(file2)) {
        return 1
    }

    ; Read and compare in chunks
    chunkSize := 4096 ; Define a chunk size (e.g., 4KB)
    while (!file1.AtEOF && !file2.AtEOF) {
        chunk1 := file1.Read(chunkSize)
        chunk2 := file2.Read(chunkSize)
        if (chunk1 != chunk2) {
            file1.Close()
            file2.Close()
            return 1 ; Mismatch found
        }
    }

    ; Close files
    file1.Close()
    file2.Close()

    return 0 ; Files are identical
}

HardlinkDllAddonsFromMainGW2ToSecondaryFolder(source, target) {

    if TestOutput_fileExist(source) {
        return 1
    }

    TestOutput_fileExist(target) ;; doesn't have to exist

    KillGW2

}
; /**
;  *
;  * @param source
;  * @param target
;  */
; __CheckDirectoriesForDifferences(source, target) {

;     LogFileName := A_Temp '\' FormatTime(, 'MM-dd.hh-mm-ss.log')

;     Log := ''
;     Log := Log 'source is ' source '`n'
;     Log := Log 'target is ' target '`n'

;     returner := []

;     MatchPath(SpecificFilePath) {
;         return StrReplace(SpecificFilePath, source, target)
;     }

;     try DirCreate(target)

;     loop files source '\*', '>File,Directory,Recurse' {
;         if RegExMatch(A_LoopFileAttrib, 'D') ; ensure matching directory structure
;         else {
;             if TheseAreDifferentFiles(A_LoopFileFullPath, MatchPath(A_LoopFileFullPath))
;             if SyncInstead != 'No'
;             HardlinkA_File(A_LoopFileFullPath, MatchPath(A_LoopFileFullPath))
;             }
;         }
;     }
;     MoveLocalDat(Name) {
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
; ;;;;;;;;;;
; $sourcePath = "C:\Users\" + $env: USERNAME + "\Documents\Guild Wars 2\InputBinds"
;     $fileNames = (Get - ChildItem - Path$sourcePath - File).Name
; foreach ($xml in $fileNames) {
;     $whereToPutLink = "C:\Users\stash\Documents\scripts\ahk\gw2\InputBinds\" + $xml
;         $LinkFrom = "C:\Users\stash\Documents\Guild Wars 2\InputBinds\" + $xml
;     New -Item - ItemType HardLink - Path$whereToPutLink - Target$LinkFrom
; }
