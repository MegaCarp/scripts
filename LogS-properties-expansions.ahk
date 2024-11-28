#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe logseq.exe")

; text expansion is called "hotstrings"

:k5*:aof::+{Enter}::{Sleep 200}area-of-focus{Sleep 200}{Enter}{Sleep 200}{Enter}{Sleep 200}{Enter}
:*:pj::+{Enter}project::{Space}[
::p::+{Enter}project::{Space}[
:*:kw::+{Enter}knowledge::{Space}
::k::+{Enter}knowledge::
::r::reference
:*:gt::+{Enter}gtd-object::{Space}
::o::+{Enter}gtd-object::
::n::[[next-action
:*:na::[[next-action]]
::t::+{Enter}task::
::c::+{Enter}context::
:*:cx::+{Enter}context::{Space}[
:*:sm::+{Enter}someday-maybe:: true
:*:tt::+{Enter}gtd-object:: task+{Enter}task::{Space}[
:*:inv::+{Enter}inventory::{Space}[

^Up::Send "{Home}" ; Ctrl+Up arrow = Home button
^Down::Send "{End}" ; Ctrl+Down arrow = End button