#Requires AutoHotkey v2.0

;; sauce https://www.autohotkey.com/boards/viewtopic.php?p=593560#p593537

Base64ToBinary(Base64) { ; https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-cryptstringtobinaryw
    static CRYPT_STRING_BASE64 := 0x00000001
    local Size := 0
    if !(DllCall("Crypt32.dll\CryptStringToBinaryW", "Str", Base64,
        "UInt", 0,
        "UInt", CRYPT_STRING_BASE64,
        "Ptr", 0,
        "UInt*", &Size,
        "Ptr", 0,
        "Ptr", 0))
        throw OSError()
    local Binary := Buffer(Size)
    if !(DllCall("Crypt32.dll\CryptStringToBinaryW", "Str", Base64,
        "UInt", 0,
        "UInt", CRYPT_STRING_BASE64,
        "Ptr", Binary,
        "UInt*", &Size,
        "Ptr", 0,
        "Ptr", 0))
        throw OSError()
    return Binary
}

BinaryToHex(Binary) { ; https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-cryptbinarytostringw
    static CRYPT_STRING_HEX := 0x0000000C | 0x40000000 ; CRYPT_STRING_HEXRAW | CRYPT_STRING_NOCRLF
    local Size := 0
    if !(DllCall("Crypt32.dll\CryptBinaryToStringW", "Ptr", Binary,
        "UInt", Binary.Size,
        "UInt", CRYPT_STRING_HEX,
        "Ptr", 0,
        "UInt*", &Size,
        "UInt"))
        throw OSError()
    local Hex := ""
    VarSetStrcapacity(&Hex, Size)
    if !(DllCall("Crypt32.dll\CryptBinaryToStringW", "Ptr", Binary,
        "UInt", Binary.Size,
        "UInt", CRYPT_STRING_HEX,
        "Str", &Hex,
        "UInt*", &Size,
        "UInt"))
        throw OSError()
    return StrUpper(Hex)
}

; a waypoint: [&BDgAAAA=]
; ; an item: [&AgH1WQAA]
; targetString := SubStr("[&AgH1WQAA]", 3, 8)
; A_Clipboard := BinaryToHex(Base64ToBinary(targetString))
; resultInHex := BinaryToHex(Base64ToBinary(targetString))
; if RegExMatch(resultInHex, "04") {
;     MsgBox "yup"
; }