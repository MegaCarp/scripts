#Requires AutoHotkey v2.0
#SingleInstance Force

Esc:: ExitApp


Gw2Launcher

Gw2Launcher() {
    if FileExist(A_MyDocuments "\..\games\gw2\blishud\Blish HUD.exe")
        BlishExe := A_MyDocuments "\..\games\gw2\blishud\Blish HUD.exe"
    else if FileExist(A_MyDocuments "\..\games\gw2\blishud\Blish HUD.exe")
        BlishExe := A_MyDocuments "\..\games\gw2\addons\Blish HUD.exe"
    else {
        MsgBox "Can't find Blish HUD! Here's where I looked: `n" A_MyDocuments "\..\games\gw2\blishud\Blish HUD.exe`n" A_MyDocuments "\..\games\gw2\addons\Blish HUD.exe"
    }

    if FileExist("C:\games\GuildWars2-arenanet\Gw2-64.exe")
        Gw2Exe := "C:\games\GuildWars2-arenanet\Gw2-64.exe"
    else {
        MsgBox "Can't find GW2! Here's where I looked: `nC:\games\GuildWars2-arenanet\Gw2-64.exe"
        ExitApp
    }

    ; Run "C:\games\GuildWars2-arenanet\Gw2-64.exe -shareArchive",,, &outID ; gw2arenanet
    ; Run "com.epicgames.launcher://apps/10cab3b738244873bacb8ec7cef8128c%3Aada1dbe6d6d64aebb788713ec8d709c0%3A8d87562b481d44dd938c6a34a87d7355?action=launch&silent=true",,, &outID ; gw2epic
    ; Run A_MyDocuments "..\games\gw2\blishud\Blish HUD.exe"

    SetCaptatrixToLaunch(*) {
        WhatToLaunch.Destroy
        LaunchGW2('Captatrix')
    }
    SetMarinaToLaunch(*) {
        WhatToLaunch.Destroy
        LaunchGW2('Marina')
    }
    SetCarpToLaunch(*) {
        WhatToLaunch.Destroy
        LaunchGW2('Carp')
    }

    CancelOperation(*) {
        WhatToLaunch.Destroy
    }

    LaunchGW2(Name) {

        ;;;; turn this into a battery of tests with C:\Users\stash\Documents\scripts\ahk\utils\InputChecker.ahk
        SourceLocalDat := "C:\Users\" A_UserName "\AppData\Roaming\Guild Wars 2\" Name ".dat"
        if !FileExist(SourceLocalDat) {
            MsgBox "SourceLocalDat " SourceLocalDat " does not exist! Exiting."
            return
        }

        TargetLocalDat := "C:\Users\" A_UserName "\AppData\Roaming\Guild Wars 2\Local.dat"
        if !FileExist(TargetLocalDat) {
            MsgBox "TargetLocalDat " TargetLocalDat " does not exist - continue regardless."
        }

        SourceBlishTodo := "C:\Users\" A_UserName "\Documents\Guild Wars 2\addons\blishhud\todos - " Name
        if !FileExist(SourceBlishTodo) {
            MsgBox "SourceBlishTodo " SourceBlishTodo " does not exist! Exiting."
            return
        }

        ; "C:\Users\stash\Documents\Guild Wars 2\addons\blishhud\events\event_states.json"
        ; Event states for Blish Event Timeers
        TargetBlishEventStates := "C:\Users\" A_UserName "\Documents\Guild Wars 2\addons\blishhud\todos"
        if !FileExist(TargetBlishEventStates) {
            MsgBox "TargetBlishEventStates " TargetBlishEventStates " does not exist! Exiting."
            return
        }

        SourceBlishEventStates := "C:\Users\" A_UserName "\Documents\Guild Wars 2\addons\blishhud\todos - " Name
        if !FileExist(SourceBlishEventStates) {
            MsgBox "SourceBlishEventStates " SourceBlishEventStates " does not exist! Exiting."
            return
        }

        TargetBlishTodo := "C:\Users\" A_UserName "\Documents\Guild Wars 2\addons\blishhud\todos"
        if !FileExist(TargetBlishTodo) {
            MsgBox "TargetBlishTodo " TargetBlishTodo " does not exist! Exiting."
            return
        }

        while ProcessExist("Gw2-64.exe")
            ProcessClose("Gw2-64.exe")
        while ProcessExist("Blish")
            ProcessClose("Blish")

        ;;;;;;;;;;;;;;;;

        loop files SourceBlishTodo '\*' {
            try FileRecycle(TargetBlishTodo '\' A_LoopFileName)
            catch {
                SplitPath SourceBlishTodo, , &OutDir
                MsgBox 'a todo has been deleted, moving it to trash`nFrom: ' A_LoopFilePath '`nTo: ' OutDir '\todo-trashed\' A_LoopFileName
                FileMove A_LoopFilePath, OutDir '\todo-trashed\' A_LoopFileName, 1
            }
        }

        FileCopy TargetBlishTodo '\*.*', SourceBlishTodo '\*.*'

        scriptFileName := A_WorkingDir '\hardlinker-script.ps1'
        try FileRecycle(scriptFileName)

        ; Local.dat
        ToWriteToScript := 'New-Item -ItemType HardLink -Target `"' SourceLocalDat '`" -Path `"' TargetLocalDat '`"`n'

        loop files SourceBlishTodo '\*'
            ToWriteToScript := ToWriteToScript 'New-Item -ItemType HardLink -Target `"' A_LoopFilePath '`" -Path `"' TargetBlishTodo '\' A_LoopFileName '`"`n'

        FileAppend ToWriteToScript, scriptFileName
        FileRecycle TargetLocalDat

        ;;;;;;;;;;;;;;;;

        ; RunWait 'pwsh.exe -File `"' scriptFileName '`"'
        RunWait 'pwsh.exe -WindowStyle Hidden -File `"' scriptFileName '`"'
        ;;;;;;;;;;;;;;;;

        RunGw2ArenaNet(Name) {
            Run BlishExe
            Run Gw2Exe " -autologin", , , &outID ; gw2arenanet
        }
        switch Name {
            case 'Captatrix': RunGw2ArenaNet(Name)
            case 'Marina': RunGw2ArenaNet(Name)
            case 'Carp':
                Run "com.epicgames.launcher://apps/10cab3b738244873bacb8ec7cef8128c%3Aada1dbe6d6d64aebb788713ec8d709c0%3A8d87562b481d44dd938c6a34a87d7355?action=launch&silent=true", , , &
                outID ; gw2epic
                Run BlishExe
            default:
        }
    }

    WhatToLaunch := Gui('AlwaysOnTop -Caption')
    WhatToLaunch.AddButton(, 'Captatrix').OnEvent('Click', SetCaptatrixToLaunch)
    WhatToLaunch.AddButton(, 'Marina').OnEvent('Click', SetMarinaToLaunch)
    WhatToLaunch.AddButton(, 'Carp').OnEvent('Click', SetCarpToLaunch)

    WhatToLaunch.Show

}

; SetTimer killMutex(), -20000

; killMutex() {

;     ; https://www.autohotkey.com/boards/viewtopic.php?t=14397

;     ; pid := 0
;     ; handle := getHandle(pid,name)
;     ; if (handle = "") {
;     ; 	return ; handle not found
;     ; }

;     HandleExecutable := A_MyDocuments "..\bin\handle\handle64.exe"

;     command := HandleExecutable A_Space "-p" A_Space . outID . A_Space "-c" A_Space . "AN-Mutex-Install-101" A_Space .
;         "-y"
;     Run command, , 'Hide'
; }

; run
; getHandle(ByRef pid, name) {
;     command := "C:\Users\Astryd\Risorse\_CircleDocks\handle.exe -a " . name
;     stdout := runStdout(command)
;     needle := "No matching" ;when Handle found nothing return in standard output "No matching handles found."
;     IfInString, stdout, %needle%
;     {
;         return ""
;     }
;     handle := RegExReplace(stdout, "s).*(...): \\Sessions\\1\\BaseNamedObjects\\_CircleDock_.*", "$1")
;     pid := RegExReplace(stdout, "s).*pid: (\d*).*", "$1")
;     return handle
; }

; Run a command and return standard output
; runStdout(command) {
;     shell := comobjcreate("wscript.shell")
;     exec := (shell.exec(comspec " /c " command))
;     stdout := exec.stdout.readall()
;     return stdout
; }
