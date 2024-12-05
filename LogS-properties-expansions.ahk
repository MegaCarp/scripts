#Requires AutoHotkey v2.0

; Pause := 7

#HotIf WinActive("ahk_exe logseq.exe")

; text expansion is called "hotstrings"

:SEk1*?:aof::{End}+{Enter}::{Sleep 7}area-of-focus{Sleep 5}{Enter}
:SEk1*?:pj::{End}+{Enter}::{Sleep 7}project{Sleep 5}{Enter}
:SEk1o:p::::{Sleep 7}project{Sleep 5}{Enter}
:SEk1*?:kw::{End}+{Enter}::{Sleep 7}knowledge{Sleep 5}{Enter}
:SEk1:k::::{Sleep 7}knowledge{Sleep 5}{Enter}
:o:r::reference
:SEk1*?:kr::{End}+{Enter}::{Sleep 7}knowledge{Sleep 5}{Enter}reference{Sleep 5}{Enter}{Sleep 5}{Enter}::{Sleep 7}area-of-focus{Sleep 5}{Enter}

:SEk1*?:gt::{End}+{Enter}::{Sleep 7}gtd-object{Sleep 5}{Enter}
:SEk1*?:otr::{End}+{Enter}::{Sleep 7}gtd-object{Sleep 5}{Enter}trash{Sleep 5}{Enter}
:SEk1*?:opr::{End}+{Enter}::{Sleep 7}gtd-object{Sleep 5}{Enter}[[Projects]]{Sleep 5}{Enter}
:SEk1o:o::::{Sleep 7}gtd-object{Sleep 5}{Enter}

:SEk1:n::[[next-action{Sleep 5}{Enter}
:SEk1:t::::{Sleep 7}task{Sleep 5}{Enter}
:SEk1:c::::{Sleep 7}context{Sleep 5}{Enter}
:SEk1*?:cx::{End}+{Enter}::{Sleep 7}context{Sleep 5}{Enter}
:SEk1*?:sm::{End}+{Enter}::{Sleep 7}someday-maybe{Sleep 5}{Enter}true{Sleep 5}{Enter}
:SEk1*?:tt::{End}+{Enter}::{Sleep 7}gtd-object{Sleep 5}{Enter}task{Sleep 5}{Enter}{Sleep 5}{Enter}::{Sleep 7}task{Sleep 5}{Enter}
:SEk1*?:inv::{End}+{Enter}::{Sleep 7}inventory{Sleep 5}{Enter}

^Up::Send "{Home}" ; Ctrl+Up arrow = Home button
^Down::Send "{End}" ; Ctrl+Down arrow = End button

+3::Send "{#}"
:*?:номер::№