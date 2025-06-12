#SingleInstance Off

; Run "C:\games\GuildWars2-arenanet\Gw2-64.exe -shareArchive",,, &outID ; gw2arenanet
Run A_MyDocuments "..\..\..\games\GuildWars2-arenanet\Gw2-64.exe",,, &outID ; gw2arenanet
; Run "com.epicgames.launcher://apps/10cab3b738244873bacb8ec7cef8128c%3Aada1dbe6d6d64aebb788713ec8d709c0%3A8d87562b481d44dd938c6a34a87d7355?action=launch&silent=true",,, &outID ; gw2epic
Run A_MyDocuments "..\games\gw2\blishud\Blish HUD.exe"

; SetTimer killMutex(), -20000

killMutex() {

    ; https://www.autohotkey.com/boards/viewtopic.php?t=14397

        ; pid := 0
        ; handle := getHandle(pid,name)
        ; if (handle = "") {
        ; 	return ; handle not found
        ; }

        HandleExecutable := A_MyDocuments "..\bin\handle\handle64.exe"

        command := HandleExecutable A_Space "-p" A_Space . outID . A_Space "-c" A_Space . "AN-Mutex-Install-101" A_Space . "-y"
        Run command,, 'Hide'
}

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