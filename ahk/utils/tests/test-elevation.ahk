#Requires AutoHotkey v2.0

if !A_IsAdmin {
    MsgBox 'not an admin'
    Run "sudo " A_ScriptFullPath
}
else
    MsgBox "is admin"