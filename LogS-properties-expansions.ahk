#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe logseq.exe")

; text expansion is called "hotstrings"

:*:aof::+{Enter}::{Sleep 100}{Enter}area-of-focus{Sleep 150}{Enter}{Sleep 100}{Enter}
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