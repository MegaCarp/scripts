#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe logseq.exe")

; text expansion is called "hotstrings"

:SEk1*:aof::+{Enter}::{Sleep 5}area-of-focus{Sleep 5}{Enter}
:SEk1*:pj::+{Enter}::{Sleep 5}project{Sleep 5}{Enter}
:SEk1o:p::::{Sleep 5}project{Sleep 5}{Enter}
:SEk1*:kw::+{Enter}::{Sleep 5}knowledge{Sleep 5}{Enter}
:SEk1:k::::{Sleep 5}knowledge{Sleep 5}{Enter}
:o:r::reference
:SEk1*:kr::+{Enter}::{Sleep 5}knowledge{Sleep 5}{Enter}reference{Sleep 5}{Enter}

:SEk1*:gt::+{Enter}::{Sleep 5}gtd-object{Sleep 5}{Enter}
:SEk1:o::::{Sleep 5}gtd-object{Sleep 5}{Enter}
:SEk1:n::[[next-action{Sleep 5}{Enter}
:SEk1*:na::[[next-action{Sleep 5}{Enter}
:SEk1:t::::{Sleep 5}task{Sleep 5}{Enter}
:SEk1:c::::{Sleep 5}context{Sleep 5}{Enter}
:SEk1*:cx::+{Enter}::{Sleep 5}context{Sleep 5}{Enter}
:SEk1*:sm::+{Enter}::{Sleep 5}someday-maybe{Sleep 5}{Enter}true{Sleep 5}{Enter}
:SEk1*:tt::+{Enter}::{Sleep 5}gtd-object{Sleep 5}{Enter}task{Sleep 5}{Enter}{Sleep 5}{Enter}::{Sleep 5}task{Sleep 5}{Enter}
:SEk1*:inv::+{Enter}::{Sleep 5}inventory{Sleep 5}{Enter}

^Up::Send "{Home}" ; Ctrl+Up arrow = Home button
^Down::Send "{End}" ; Ctrl+Down arrow = End button

+3::Send "{#}"
:*:номер::№