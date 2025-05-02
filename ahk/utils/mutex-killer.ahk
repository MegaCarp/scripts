; #Include launch-gw2-and-blish.ahk
#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon
#Include defaults-global.ahk

;; have to add this before cmd will work with Cyrillics
; for Cyrillics - https://superuser.com/a/269857
; or run this as admin
; %SystemRoot%\System32\reg.exe ADD "HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor" /f /t REG_SZ /v "AUTORUN" /d "@chcp 65001>nul"

;; tried to run it invisibly using vbs script
; wscript.exe "C:\Users\Денис\Documents\scripts\run-invisibly.vbs" "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe `"C:\Users\Денис\Documents\scripts\launch-gw2-and-blish_testing.ahk`""

; make an map of arrays
; keys are populated by cmd\tasklist
; handle then fills the keys' arrays with mutexes hex-ids for every available handles with a name provided
; iterate through the map with handle.exe, where for every key, used as the PID, every HEX is being dropped

; outID := ProcessExist("Gw2-64.exe")
; killMutex()

; handle.exe

; usage: handle [[-a [-l]] [-v|-vt] [-u] | [-c <handle> [-y]] | [-s]] [-p <process>|<pid>] [name] [-nobanner]
;   -a         Dump all handle information.
;   -l         Just show pagefile-backed section handles.
;   -c         Closes the specified handle (interpreted as a hexadecimal number).
;              You must specify the process by its PID. Requires administrator
;              rights.
;              WARNING: Closing handles can cause application or system instability.
;   -g         Print granted access.
;   -y         Don't prompt for close handle confirmation.
;   -s         Print count of each type of handle open.
;   -u         Show the owning user name when searching for handles.
;   -v         CSV output with comma delimiter.
;   -vt        CSV output with tab delimiter.
;   -p         Dump handles belonging to process (partial name accepted).
;   name       Search for handles to objects with <name> (fragment accepted).
;   -nobanner  Do not display the startup banner and copyright message.

; No arguments will dump all file references.

; gwPID := ProcessExist("gw2-64.exe")
; ; A_Clipboard :=
; str := RunCMD(A_ComSpec " /c" handleExe -p " gwPID " -c AN-Mutex-Install-101 -y", ,
;     "utf-8", DropHeadersAndGrabPIDs)
; ; Gw2-64.exe,22364,<Unknown type>,0x000003E8,\Sessions\1\BaseNamedObjects\AN-Mutex-Install-101

; ; not found
; ;  A_Clipboard :=
; RunCMD(A_ComSpec " /c" handleExe -p " gwPID " AN-Mutex-Install-1011", ,
;     "utf-8", DropHeadersAndGrabPIDs)
; ; No matching handles found.

; ; a list of processes
; ; A_Clipboard :=
; ; str := StrReplace(RunCMD(A_ComSpec " /c tasklist /svc /nh /fo csv /fi `"ImageName eq firefox.exe`"", , "utf-8",    DropHeadersAndGrabPIDs), "`r", "__")

MutexKiller(ProcessName, MutexName, Testing := '') {

    mutexesPerPid := 0

    switch {
        case Type(ProcessName) = 'Integer' AND ProcessExist(ProcessName): ; can pass a PID instead of being being forced to search for it by name
            PIDs := [ProcessName]

        case ProcessExist(ProcessName):
            PIDs := StrSplit(RunCMD(A_ComSpec " /c tasklist /svc /nh /fo csv /fi `"ImageName eq " ProcessName "`"", ,
                "utf-8",
                tasklist_DropHeadersAndGrabPIDs), ",")

        default:
            return "Invalid process name."
    }

    try PIDs.Pop

    if Testing = "PID-Param"
        return PIDs

    ; "firefox.exe","14684","N/A"
    ; "firefox.exe","16632","N/A"
    ;  etc

    ; gwPID := ProcessExist("gw2-64.exe")
    ; A_Clipboard :=
    mutexesPerPid := Map()
    if PIDs {
        for id, value IN PIDs {
            arr := StrSplit(RunCMD(A_ComSpec " /c" handleExe "-p " value " -a " MutexName, ,
                "utf-8", handle64Exe_DropHeadersAndGrabHexOfHandles), ",") ; Process,PID,Type,Handle,Name `n Gw2-64.exe,20220,Mutant,0x0000034C,\Sessions\1\BaseNamedObjects\AN-Mutex-Install-101
            try arr.Pop
            mutexesPerPid[value] := arr
        }
    }

    if mutexesPerPid {
        ;;;;; elevation

        MsgBox 'found mutex'

        taskName := "`"\ahk\utils\Run Mutex Killer as Admin`""
        taskAction := "`"" A_AhkPath A_Space A_ScriptFullPath "`""
        ComBeginnerStr := A_ComSpec " /c "
        ; ComBeginnerStr := "C:\Users\Денис\Documents\scripts\run-invisibly.vbs " A_ComSpec " /c "
        if !A_IsAdmin {
            msgbox "not! admin"
            ; /f - don't error out if the task already exists
            ; MsgBox RunCMD(ComBeginnerStr "schtasks /delete /tn " taskName " /f")
            ; final_str := ComBeginnerStr "schtasks /create /tn " taskName " /tr " taskAction " /sc ONCE /st 17:00 /sd 11/11/2032 /f"

            ; A_Clipboard := final_str
            ; MsgBox RunCMD(final_str,, "utf-8")

            RunWait(ComBeginnerStr "schtasks /run /tn " taskName "")

            ; Run('*RunAs ' A_ScriptFullPath, , , &ExistingAdminPid)
            ExitApp
        }

        msgbox "admin"

        for top_id, value IN mutexesPerPid
            for id, value IN value {
                MsgBox "PID " top_id " has mutex " value
                MsgBox RunCMD(A_ComSpec " /c" handleExe " -p " top_id "-c " value " -y", , "utf-8")
            }

        ;;;;;;;;;
    }

    mutexesPerPid := '' ; drop map
    ; MsgBox RunCMD(A_ComSpec " /c" handleExe " -p " value " -c AN-Mutex-Install-101 -y", ,
    ;     "utf-8", DropHeadersAndGrabPIDs)
    ; Gw2-64.exe,22364,<Unknown type>,0x000003E8,\Sessions\1\BaseNamedObjects\AN-Mutex-Install-101

    ; ; not found
    ; ; A_Clipboard :=
    ; RunCMD(A_ComSpec " /c tasklist /svc /nh /fo csv /fi `"ImageName eq firefox111.exe`"", , "utf-8", DropHeadersAndGrabPIDs
    ; )
    ; ; INFO: No tasks are running which match the specified criteria.
    tasklist_DropHeadersAndGrabPIDs(InputLine, LineNum) {
        if RegExMatch(InputLine, "INFO: No tasks are running which match the specified criteria.") OR
        RegExMatch(InputLine, "Process,PID,Type,Handle,Name") ;  remove header row
            return
        else {
            InputLine := CSVParser.ToArray(InputLine)
            return InputLine[1][2] ","
        }
    }

    handle64Exe_DropHeadersAndGrabHexOfHandles(InputLine, LineNum) {
        if RegExMatch(InputLine, "No matching handles found.") ; processing handle.exe output
            return
        else {
            ; return InputLine
            InputLine := CSVParser.ToArray(InputLine)
            MsgBox InputLine[1][4] ","
            return InputLine[1][4] ","
        }
    }
}
