; sauce
; https://www.autohotkey.com/boards/viewtopic.php?f=83&t=120470&sid=fa2e031d4e936ec27e54e5ba5b7cbdbc

BufToStr(&Src, &Trg, TrgIsHex := False)                    ;  By SKAN for ah2 on D66U/D68I
{                                                          ;   @ autohotkey.com/r?t=120470
    if Type(Src) != "Buffer" Or Src.Size < 1
        return 0

    local Flags := (TrgIsHex ? 0xC : 0x1) | 0x40000000
    , Bytes := Src.Size
    , RqdCap := 1 + (TrgIsHex ? (Bytes * 2) : ((Ceil(Bytes * 4 / 3) + 3) & ~0x03))

    VarSetStrCapacity(&Trg, RqdCap - 1)
    return DllCall("Crypt32\CryptBinaryToStringW", "ptr", Src, "int", Bytes
        , "int", Flags, "str", Trg, "intp", &RqdCap)
}

StrToBuf(&Src, &Trg, SrcIsHex := False)                    ;  By SKAN for ah2 on D66U/D68I
{                                                          ;   @ autohotkey.com/r?t=120470
    if Type(Src) != "String"
        return 0

    local Flags := (SrcIsHex ? 0xC : 0x1)
    , EqTo := SrcIsHex ? 0 : (SubStr(Src, -2, 1) = "=") + (SubStr(Src, -1) = "=")
    , Bytes := SrcIsHex ? StrLen(Src) // 2 : (StrLen(Src) - EqTo) * 3 // 4

    Trg := Buffer(Bytes)
    return DllCall("Crypt32\CryptStringToBinaryW", "str", Src, "int", StrLen(Src)
    , "int", Flags, "ptr", Trg, "intp", &Bytes, "int", 0, "int", 0)
}

TxtEnc(Str) {
    local Bytes := StrPut(Str, "utf-8") - 1
    , Src := Buffer(Bytes, 0)
    , Trg := ""

    StrPut(Str, Src, Bytes, "utf-8")
    BufToStr(&Src, &Trg)

    return Trg
}

TxtDec(Src) {
    local Trg := ""
    StrToBuf(&Src, &Trg)
    return StrGet(Trg, "utf-8")
}

; base64toBinary(Str) {
;     local Bytes := StrPut(Str, "utf-8") - 1
;     , Src := Buffer(Bytes, 0)
;     , 
; }
#Requires AutoHotkey v2.0
#SingleInstance
ImageData := "AQAAAAA="


StrToBuf(&ImageData, &Bin)
BinStr := StrGet(Bin)

MsgBox(BinStr)