BufToStr(&Src, &Trg, TrgIsHex := False)                    ;  By SKAN for ah2 on D66U/D68I
{                                                          ;   @ autohotkey.com/r?t=120470
    If  Type(Src) != "Buffer"  Or  Src.Size < 1
        Return 0

    Local  Flags   :=  (TrgIsHex ? 0xC : 0x1) | 0x40000000
        ,  Bytes   :=  Src.Size
        ,  RqdCap  :=  1 + ( TrgIsHex ? ( Bytes * 2 ) : ( (Ceil(Bytes*4/3) +3) & ~0x03 ) )

    VarSetStrCapacity(&Trg, RqdCap - 1)
    Return  DllCall( "Crypt32\CryptBinaryToStringW", "ptr",Src, "int",Bytes
                   , "int",Flags, "str",Trg, "intp",&RqdCap )
}


StrToBuf(&Src, &Trg, SrcIsHex := False)                    ;  By SKAN for ah2 on D66U/D68I
{                                                          ;   @ autohotkey.com/r?t=120470
    If  Type(Src) != "String"
        Return 0

    Local  Flags   :=  (SrcIsHex ? 0xC : 0x1)
        ,  EqTo    :=  SrcIsHex ?  0  :  (SubStr(Src,-2,1) = "=") + (SubStr(Src,-1) = "=")
        ,  Bytes   :=  SrcIsHex ?  StrLen(Src)//2  :  (StrLen(Src) - EqTo) * 3 // 4

    Trg  :=  Buffer(Bytes)
    Return  DllCall( "Crypt32\CryptStringToBinaryW", "str",Src, "int",StrLen(Src)
                   , "int",Flags, "ptr",Trg, "intp",&Bytes, "int",0, "int",0 )
}


TxtEnc(Str)
{
    Local  Bytes  :=  StrPut(Str,"utf-8") - 1
        ,  Src    :=  Buffer(Bytes, 0)
        ,  Trg    :=  ""

    StrPut(Str, Src, Bytes, "utf-8")
    BufToStr(&Src, &Trg)

Return Trg
}


TxtDec(Src)
{
    Local  Trg  :=  ""
    StrToBuf(&Src, &Trg)
    Return StrGet(Trg, "utf-8")
}


#Requires AutoHotkey v2.0
#SingleInstance

; Base64 := TxtEnc("The Quick Brown Fox..")
Text   := TxtDec("AQAAAAA=")

MsgBox(  "`n" Text )
