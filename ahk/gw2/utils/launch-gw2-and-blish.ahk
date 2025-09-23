#Requires AutoHotkey v2.0
#SingleInstance Force

if FileExist(A_MyDocuments "\..\games\gw2\blishud\Blish HUD.exe")
    BlishExe := A_MyDocuments "\..\games\gw2\blishud\Blish HUD.exe"
else if FileExist(A_MyDocuments "\..\games\gw2\blishud\Blish HUD.exe")
    BlishExe := A_MyDocuments "\..\games\gw2\addons\Blish HUD.exe"
else {
    MsgBox "Can't find Blish HUD! Here's where I looked: `n" A_MyDocuments "\..\games\gw2\blishud\Blish HUD.exe`n" A_MyDocuments "\..\games\gw2\addons\Blish HUD.exe"
}

if FileExist("C:\games\Gw2Launcher.exe")
    Gw2Exe := "C:\games\Gw2Launcher.exe"
; if FileExist("C:\games\GuildWars2-arenanet\Gw2-64.exe")
;     Gw2Exe := "C:\games\GuildWars2-arenanet\Gw2-64.exe"
else {
    MsgBox "Can't find GW2! Here's where I looked: `nC:\games\GuildWars2-arenanet\Gw2-64.exe"
    ; ExitApp ;; this script has been folded as a function into main so this would crash the whole thing
}

Gw2LauncherGui := Gui('AlwaysOnTop -Caption')

Gw2LauncherGui.AddText(, 'Use Control with kbd to move Local.dat`nand to close other instances of GW.')
Gw2LauncherGui.AddButton('vCaptatrix x50', '(C)aptatrix').OnEvent('Click', Gw2Launcher)
Gw2LauncherGui.AddButton('vPoro x50', '(P)oro').OnEvent('Click', Gw2Launcher)
Gw2LauncherGui.AddButton('vCarp x50', 'C(a)rp').OnEvent('Click', Gw2Launcher)

Gw2LauncherGui['Carp'].GetPos(, , , &heightOut)

Gw2LauncherGui.AddButton('vUpdate x50 yp+' heightOut * 2, '(U)pdate').OnEvent('Click', Gw2Launcher)
Gw2LauncherGui.AddButton('vKillAll x50', '(K)ill all Gw2').OnEvent('Click', Gw2Launcher)
Gw2LauncherGui.AddButton('vKillBlish x50', 'Kill (B)lish').OnEvent('Click', Gw2Launcher)

; MouseGetPos ,, &outid

#HotIf WinActive('ahk_id ' Gw2LauncherGui.Hwnd)
Esc:: Gw2LauncherGui.Hide

c:: Gw2Launcher(ThisHotkey)
p:: Gw2Launcher(ThisHotkey)
a:: Gw2Launcher(ThisHotkey)

^c:: Gw2Launcher(ThisHotkey)
^p:: Gw2Launcher(ThisHotkey)
^a:: Gw2Launcher(ThisHotkey)

u:: Gw2Launcher(ThisHotkey)
k:: Gw2Launcher(ThisHotkey)
b:: Gw2Launcher(ThisHotkey)
#HotIf

Gw2Launcher(MaybeHotkey := '', *) {

    if Type(MaybeHotkey) = 'Gui.Button'
        MaybeHotkey := MaybeHotkey.Name

    static CaptatrixPID := ''
    static PoroPID := ''
    static CarpPID := ''

    ; if WinExist('ahk_exe Gw2-64.exe') {
    ;     AddButtonForBlish(ControlNameForTheGW2_OrDeleteBlishButton, BlishNameButton) {
    ;         if ControlNameForTheGW2_OrDeleteBlishButton {
    ;             ControlGetPos &xout, &yout, &width, &height, Gw2LauncherGui[ControlNameForTheGW2_OrDeleteBlishButton]
    ;             Gw2LauncherGui.AddButton('v' BlishNameButton ' x' xout + width + 20 ' y' height, BlishNameButton)
    ;         } else try Gw2LauncherGui[BlishNameButton].Delete
    ;     }

    ;     AddButtonForBlish 'Captatrix', 'Launch_Captatrix_Blish'
    ;     AddButtonForBlish 'Poro', 'Launch_Poro_Blish'
    ;     AddButtonForBlish 'Carp', 'Launch_Carp_Blish'

    ; } else {
    ;     AddButtonForBlish '', 'Launch_Captatrix_Blish'
    ;     AddButtonForBlish '', 'Launch_Poro_Blish'
    ;     AddButtonForBlish '', 'Launch_Carp_Blish'
    ; }
    
    ; if ProcessExist(CaptatrixPID) {
    ;     ControlGetPos &xout, &yout, , , Gw2LauncherGui['Captatrix']
    ;     try Gw2LauncherGui.AddText('x' xout - 60 'y' yout ' vRelaunchCaptatrix', 'relaunch ')
    ; } else
    ;     try Gw2LauncherGui['RelaunchCaptatrix'].Delete

    ; if ProcessExist(PoroPID) {
    ;     ControlGetPos &xout, &yout, , , Gw2LauncherGui['Poro']
    ;     try Gw2LauncherGui.AddText('x' xout - 60 'y' yout ' vRelaunchPoro', 'relaunch ')
    ; } else
    ;     try Gw2LauncherGui['RelaunchPoro'].Delete

    ; if ProcessExist(CarpPID) {
    ;     ControlGetPos &xout, &yout, , , Gw2LauncherGui['Carp']
    ;     try Gw2LauncherGui.AddText('x' xout - 60 'y' yout ' vRelaunchCarp', 'relaunch ')
    ; } else
    ;     try Gw2LauncherGui['RelaunchCarp'].Delete

    switch {
        case (MaybeHotkey = 'c' OR MaybeHotkey = '^c' OR MaybeHotkey = "Captatrix"):
            try Gw2LauncherGui.Hide
            ; Run BlishExe

            if ProcessExist(CaptatrixPID)
                while (ProcessExist(CaptatrixPID))
                    ProcessClose CaptatrixPID

            ; if MaybeHotkey = '^c'
                ; MoveLocalDat('Captatrix')

            Run Gw2Exe A_Space "-l:silent -l:uid:1", , , &CaptatrixPID ; gw2arenanet
            ; Run Gw2Exe A_Space "-autologin -mumble MumbleLink_Captatrix.6428 -shareArchive", , , &CaptatrixPID ; gw2arenanet

        case (MaybeHotkey = 'p' OR MaybeHotkey = '^p' OR MaybeHotkey = "Poro"):
            try Gw2LauncherGui.Hide
            ; Run BlishExe

            if ProcessExist(PoroPID)
                while (ProcessExist(PoroPID))
                    ProcessClose PoroPID

            ; if MaybeHotkey = '^p'
            ;     MoveLocalDat('Poro')

            Run Gw2Exe A_Space "-l:silent -l:uid:2", , , &PoroPID ; gw2arenanet
            ; Run Gw2Exe A_Space "-autologin -shareArchive", , , &PoroPID ; gw2arenanet

        case (MaybeHotkey = 'a' OR MaybeHotkey = '^a' OR MaybeHotkey = "Carp"):
            try Gw2LauncherGui.Hide
            Run BlishExe A_Space '--mumble "MumbleLink_AltPaid" --settings "mbprofiles\blishhud.AltPaid"'

            if ProcessExist(CarpPID)
                while (ProcessExist(CarpPID))
                    ProcessClose CarpPID

            ; if MaybeHotkey = '^a'
            ;     MoveLocalDat('Carp')

            Run "com.epicgames.launcher://apps/10cab3b738244873bacb8ec7cef8128c%3Aada1dbe6d6d64aebb788713ec8d709c0%3A8d87562b481d44dd938c6a34a87d7355?action=launch&silent=true", , , &
                CarpPID ; gw2epic

                ; SetTimer ChangeWinTitleForCarp, -20000

                ; ChangeWinTitleForCarp(*) {
                ;     WinSetTitle('Carp', 'ahk_pid ' CarpPID)
                ; }

        case (MaybeHotkey = 'u' OR MaybeHotkey = "Update"):
            try Gw2LauncherGui.Hide
            KillGW2
            Run Gw2Exe A_Space '-update' A_Space '`"' A_AppData '\Guild Wars 2\*.dat' '`"'

        case (MaybeHotkey = 'k' OR MaybeHotkey = "KillAll"):
            KillGW2

        case (MaybeHotkey = 'b' OR MaybeHotkey = "KillBlish"):
            while ProcessExist('Blish HUD.exe')
                ProcessClose('Blish HUD.exe')

        default:
            try Gw2LauncherGui.Show('Restore')

    }

    ; Gw2Launcher.AddCheckbox('vMultibox')
    ; Gw2Launcher.AddText(, 'Multibox?')

    ; Run "C:\games\GuildWars2-arenanet\Gw2-64.exe -shareArchive",,, &outID ; gw2arenanet
    ; Run "com.epicgames.launcher://apps/10cab3b738244873bacb8ec7cef8128c%3Aada1dbe6d6d64aebb788713ec8d709c0%3A8d87562b481d44dd938c6a34a87d7355?action=launch&silent=true",,, &outID ; gw2epic
    ; Run A_MyDocuments "..\games\gw2\blishud\Blish HUD.exe"

    MoveLocalDat(Name) {

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
        ; Event states for Blish Event Timers
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

        KillGW2
        ;;;;;;;;;;;;;;;

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

    }

}

KillGW2(PID := '') {

    if PID
        ProcessClose PID
    else
        while ProcessExist("Gw2-64.exe")
            ProcessClose("Gw2-64.exe")
}

LaunchBlish() {
    Run BlishExe

    CheckIfItRuns(*) {
        if !ProcessExist('Blish HUD.exe')
            Run BlishExe
        else
            SetTimer CheckIfItRuns, 0
    }

    SetTimer CheckIfItRuns, 100 * 60 * 2
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
