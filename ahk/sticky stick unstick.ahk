#Requires AutoHotkey v2.0
#SingleInstance Force

; StickyKeys get/set example for AutoHotkey v2 using SystemParametersInfoA

SPI_GETSTICKYKEYS := 0x003A
SPI_SETSTICKYKEYS := 0x003B
SPIF_SENDCHANGE := 0x0002  ; notify system of change

; SKF flags (common)
SKF_STICKYKEYSON := 0x00000001
SKF_HOTKEYACTIVE := 0x00000002
SKF_CONFIRMHOTKEY := 0x00000008
SKF_HOTKEYSOUND := 0x00000010
SKF_AVAILABLE := 0x00000040
SKF_INDICATOR := 0x00000080
SKF_TRISTATE := 0x00000100

; Build a buffer for STICKYKEYS: cbSize (UInt), dwFlags (UInt)
skBuf := Buffer(8)            ; allocate 8 bytes
NumPut(8, skBuf, 0, "UInt")         ; cbSize = sizeof(STICKYKEYS) = 8
NumPut('uint',, skBuf, 0, "UInt")         ; cbSize = sizeof(STICKYKEYS) = 8
NumPut(0, skBuf, 4, "UInt")         ; initial dwFlags = 0

newFlags := currentFlags ^ SKF_STICKYKEYSON

; --- GET current StickyKeys ---
if DllCall("user32.dll\SystemParametersInfoA"
        , "UInt", SPI_GETSTICKYKEYS
        , "UInt", 0
        , "Ptr", &skBuf
        , "UInt", 0) = 0
{
    MsgBox "Failed to get STICKYKEYS (Get)."
    ExitApp
}
currentFlags := NumGet(skBuf, 4, "UInt")
MsgBox Format("Current STICKYKEYS dwFlags = 0x{1:08X}", currentFlags)
