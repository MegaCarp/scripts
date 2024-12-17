#Requires AutoHotkey v2.0

; This script converts a binary number to a hexadecimal number
; https://www.autohotkey.com/board/topic/49990-binary-and-decimal-conversion/

; More at
; https://www.autohotkey.com/boards/viewtopic.php?t=119727

bin2dec := (n) => (StrLen(n) > 1 ? bin2dec(SubStr(n, 1, -1)) << 1 : 0) | SubStr(n, -1)
; MsgBox Format('0x{:X}', bin2dec('1111100110111110'))