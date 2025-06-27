#Requires AutoHotkey v2.0
#SingleInstance Force

Gw2Launcher

Gw2Launcher() {
    if FileExist(A_MyDocuments "\..\games\gw2\blishud\Blish HUD.exe")
        BlishExe := A_MyDocuments "\..\games\gw2\blishud\Blish HUD.exe"
    else if FileExist(A_MyDocuments "\..\games\gw2\blishud\Blish HUD.exe")
        BlishExe := A_MyDocuments "\..\games\gw2\addons\Blish HUD.exe"
    else {
        MsgBox "Can't find Blish HUD! Here's where I looked: `n" A_MyDocuments "\..\games\gw2\blishud\Blish HUD.exe`n" A_MyDocuments "\..\games\gw2\addons\Blish HUD.exe"
        ExitApp
    }

    if FileExist("C:\games\GuildWars2-arenanet\Gw2-64.exe")
        Gw2Exe := "C:\games\GuildWars2-arenanet\Gw2-64.exe"
    else MsgBox "Can't find GW2! Here's where I looked: `nC:\games\GuildWars2-arenanet\Gw2-64.exe"

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

        SourceLocalDat := "C:\Users\" A_UserName "\AppData\Roaming\Guild Wars 2\" Name ".dat"
        TargetLocalDat := "C:\Users\" A_UserName "\AppData\Roaming\Guild Wars 2\Local.dat"

        SourceBlishTodo := "C:\Users\" A_UserName "\Documents\Guild Wars 2\addons\blishhud\todos - " Name
        TargetBlishTodo := "C:\Users\" A_UserName "\Documents\Guild Wars 2\addons\blishhud\todos"

;         ScriptText := "
; (
;         $fileNames = (Get-ChildItem -Path "{SourceBlishTodo}" -File).Name ``
;             foreach ($xml in $fileNames) `{``
;             ``
;             $sourcePath = "C:\Users\stash\Documents\scripts\ahk\gw2\InputBinds\" + $xml``
;                 $targetPath = "C:\Users\stash\Documents\Guild Wars 2\InputBinds\" + $xml``
;                 ``
;             New-Item -ItemType HardLink -Path $sourcePath -Target $targetPath``
;         `}
; Another way of using variables with a continuation section.
; Input value 1: {1}
; Input value 2: {2}
; )"

        RunGw2ArenaNet(Name) {
            while ProcessExist("Gw2-64.exe")
                ProcessClose("Gw2-64.exe")
            while ProcessExist("Blish")
                ProcessClose("Blish")


            RunWait "PowerShell.exe -File "

            FileCopy "C:\Users\" A_UserName "\AppData\Roaming\Guild Wars 2\" Name ".dat", "C:\Users\" A_UserName "\AppData\Roaming\Guild Wars 2\Local.dat",
                1 ; change to hardlink
            FileCopy "C:\Users\" A_UserName "\Documents\Guild Wars 2\addons\blishhud\todos - " Name, "C:\Users\" A_UserName "\Documents\Guild Wars 2\addons\blishhud\todos",
                1 ; change to hardlink
            Sleep 200
            Run BlishExe
            Run Gw2Exe " -autologin", , , &outID ; gw2arenanet
        }
        switch Name {
            case 'Captatrix': RunGw2ArenaNet(Name)
            case 'Marina': RunGw2ArenaNet(Name)
            case 'Carp':
                while ProcessExist("Gw2-64.exe")
                    ProcessClose("Gw2-64.exe")
                Run "com.epicgames.launcher://apps/10cab3b738244873bacb8ec7cef8128c%3Aada1dbe6d6d64aebb788713ec8d709c0%3A8d87562b481d44dd938c6a34a87d7355?action=launch&silent=true", , , &
                    outID ; gw2epic
                Run BlishExe
            default:
        }
    }

    WhatToLaunch := Gui()
    WhatToLaunch.AddButton(, 'Captatrix').OnEvent('Click', SetCaptatrixToLaunch)
    WhatToLaunch.AddButton(, 'Marina').OnEvent('Click', SetMarinaToLaunch)
    WhatToLaunch.AddButton(, 'Carp').OnEvent('Click', SetCarpToLaunch)
    WhatToLaunch.AddButton(, 'Cancel').OnEvent('Click', CancelOperation)

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
