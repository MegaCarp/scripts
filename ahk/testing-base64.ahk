; =============================================================================================================================================================
; Author ........: jNizM
; Released ......: 2016-10-21
; Modified ......: 2023-01-13
; Tested with....: AutoHotkey v2.0.2 (x64)
; Tested on .....: Windows 11 - 22H2 (x64)
; Function ......: Base64ToString()
;
; Parameter(s)...: Base64 - encoded string
;
; Return ........: Converts a base64 string to a readable string.
; sauce
; https://github.com/jNizM/ahk-scripts-v2/blob/main/src/Strings/Base64ToString.ahk
; =============================================================================================================================================================

#Requires AutoHotkey v2.0


Base64ToString(Base64)
{
	static CRYPT_STRING_BASE64 := 0x00000001

	if !(DllCall("crypt32\CryptStringToBinaryW", "Str", Base64, "UInt", 0, "UInt", CRYPT_STRING_BASE64, "Ptr", 0, "UInt*", &Size := 0, "Ptr", 0, "Ptr", 0))
		throw OSError()

	String := Buffer(Size)
	if !(DllCall("crypt32\CryptStringToBinaryW", "Str", Base64, "UInt", 0, "UInt", CRYPT_STRING_BASE64, "Ptr", String, "UInt*", Size, "Ptr", 0, "Ptr", 0))
		throw OSError()

	return NumGet(String, "Int64")
}


; =============================================================================================================================================================
; Example
; =============================================================================================================================================================
MsgBox  Format("{:x}", Base64ToString("AgGqtgAA"))
; => The quick brown fox jumps over the lazy dog

