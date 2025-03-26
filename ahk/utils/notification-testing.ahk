#Requires AutoHotkey v2.0
#Include defaults-global.ahk

 test := Notification("test", "test-notification", A_MyDocuments "\Screenshot 2025-03-17 200015.png",, 3)
 test.Send() 

; SplitPath("parent\child\grandchild\",,&OutDir)
; MsgBox OutDir

