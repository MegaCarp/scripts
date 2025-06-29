; #Include launch-gw2-and-blish.ahk
#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon
#Include ..\mutex-killer.ahk

testPName := WinGetProcessName('A')
testPID := ProcessExist(testPName)

nonexistantPID := 1111
while (ProcessExist(nonexistantPID))
    nonexistantPID := Random(1111, 999999)

testingArray := [
    ["PID-Param", nonexistantPID, "Invalid process name."]
    ["PID-Param", testPName, [testPID]]
    ["PID-Param", testPID, [testPID]]
    ["PID-Param", testPID, [testPID]]
    ["PID-Param", testPID, [testPID]]
]

; Run "a_MutexProcess.ahk",,, &MutPID
; ; mutex1 := Mutex('Testing')

; OutputDebug MutPID




; MutexKiller()













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
