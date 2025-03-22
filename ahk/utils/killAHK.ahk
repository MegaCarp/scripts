#Requires AutoHotkey v2.0
#SingleInstance Force

^+Escape:: Run "C:\Program Files\PowerShell\7\pwsh.exe killAHK.ps1"
^+!Escape:: Run "..\..\default-scripts.ahk"