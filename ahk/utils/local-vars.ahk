#Requires AutoHotkey v2.0

SplitPath(A_MyDocuments, , &Home)
handleExe := A_MyDocuments "\scripts\ahk\lib\handle\handle64.exe"
handleExe := A_Space handleExe A_Space "-nobanner -v" A_Space