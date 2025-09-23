#Requires AutoHotkey v2.0
#SingleInstance Force
#Include defaults-global.ahk

HardlinkA_File(from, to) {
    ; Create the hard link using DllCall
    ; DllCall("CreateHardLink", Str, lpFileName, Str, lpExistingFileName, Ptr, lpSecurityAttributes)
    ; lpFileName: The path to the new hard link
    ; lpExistingFileName: The path to the existing file
    ; lpSecurityAttributes: Optional security attributes (set to 0 for default)
    try success := DllCall("CreateHardLink", "Str", from, "Str", to, "Ptr", 0)

    ; Check if the hard link creation was successful
    if !success
        MsgBox "Failed to create hard link. Error: " A_LastError
}

Hardlink_RemoveTarget_HardlinkSource(from, to, exceptionsArray := '', dryRun := 'Yes') {

    if TestOutput_FileExistAndIsType(from, 'D')
        return 1

    if TestOutput_FileExist(to) ;; doesn't have to exist
        DirCreate to
    else
        if TestOutput_fileType(to, 'D')
            return 1

    if exceptionsArray AND TestOutput_ObjectType(exceptionsArray, 'Array')
        return 1

    if exceptionsArray
        for id, value IN exceptionsArray { ; array can contain full paths
            SplitPath value, &OutName
            exceptionsArray[id] := OutName
        }

    tempDirectory := A_Temp '\' A_Now
    LogFile := tempDirectory '\.log'

    DirCreate tempDirectory

    Logging FormatTime(, "'Date:' MM/dd/yy 'Time:' hh:mm:ss tt") '`n', LogFile

    if dryRun = 'Yes'
        Logging('Dry run`n`n', LogFile)

    if exceptionsArray {
        for id, value IN exceptionsArray {
            loop files to '\*\' value, 'FDR' {

                NewPath := StrReplace(A_LoopFileFullPath, to, tempDirectory)

                Logging 'Moving the exception ' value ' from ' A_LoopFileFullPath ' to ' NewPath, LogFile

                if dryRun != 'Yes'
                    FileMove(A_LoopFileFullPath, NewPath '\*.*')
            }
        }

        Logging '`n======`n', LogFile
    }

    Logging 'Cleaning out the target directory ' to, LogFile

    if dryRun != 'Yes'
        FileDelete(to '\*')

    Logging '`n======`n', LogFile

    loop files from '\*', 'FDR' {

        NewPath := StrReplace(A_LoopFileFullPath, from, to)

        if RegExMatch(A_LoopFileAttrib, 'D') {
            Logging A_LoopFileFullPath ' is a directory, mirroring in ' NewPath '`n', LogFile

            if dryRun != 'Yes'
                DirCreate NewPath

        } else {

            Logging 'Hardlinking file from ' A_LoopFileFullPath ' to ' NewPath '`n', LogFile

            if dryRun != 'Yes'
                HardlinkA_File A_LoopFileFullPath, NewPath

        }

    }

    Logging '`n======`n', LogFile

    LogFileNewPath := to '\hardlinking--' FormatTime(, 'MM-dd--hh-mm') '.log'

    if exceptionsArray {
        loop files tempDirectory, 'FDR' {

            NewPath := StrReplace(A_LoopFileFullPath, tempDirectory, to)

            Logging 'Moving the exception back from ' A_LoopFileFullPath ' to ' NewPath, LogFile

            if dryRun != 'Yes'
                FileMove(A_LoopFileFullPath, NewPath '\*.*')
        }

    }

    FileMove LogFile, LogFileNewPath, 1
    Run LogFileNewPath
}
