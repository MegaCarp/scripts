; Modified from the v1.1 open source project: libcrypt.ahk
; The original project maintainer is: joedf
; The original project uses: MIT license
; https://github.com/ahkscript/libcrypt.ahk
; I also referred to thqby's open source project: https://github.com/thqby/ahk2_lib/blob/master/Base64.ahk
;
; sauce
; https://www.autohotkey.com/boards/viewtopic.php?t=112821

LC_Base64_Encode_Text(Text_, Encoding_ := "UTF-8")
{
    Bin_ := Buffer(StrPut(Text_, Encoding_))
    LC_Base64_Encode(&Base64_, &Bin_, StrPut(Text_, Bin_, Encoding_) - 1)
    return Base64_
}

LC_Base64_Decode_Text(Text_, Encoding_ := "UTF-8")
{
    Len_ := LC_Base64_Decode(&Bin_, &Text_)
    return StrGet(StrPtr(Bin_), Len_, Encoding_)
}

LC_Base64_Encode(&Out_, &In_, In_Len)
{
    return LC_Bin2Str(&Out_, &In_, In_Len, 0x40000001)
}

LC_Base64_Decode(&Out_, &In_)
{
    return LC_Str2Bin(&Out_, &In_, 0x1)
}

LC_Bin2Str(&Out_, &In_, In_Len, Flags_)
{
    DllCall("Crypt32.dll\CryptBinaryToString", "Ptr", In_, "UInt", In_Len, "UInt", Flags_, "Ptr", 0, "UInt*", &Out_Len := 0)
    VarSetStrCapacity(&Out_, Out_Len * 2)
    DllCall("Crypt32.dll\CryptBinaryToString", "Ptr", In_, "UInt", In_Len, "UInt", Flags_, "Str", Out_, "UInt*", &Out_Len)
    return Out_Len
}

LC_Str2Bin(&Out_, &In_, Flags_)
{
    DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", StrPtr(In_), "UInt", StrLen(In_), "UInt", Flags_, "Ptr", 0, "UInt*", &Out_Len := 0, "Ptr", 0, "Ptr", 0)
    VarSetStrCapacity(&Out_, Out_Len)
    DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", StrPtr(In_), "UInt", StrLen(In_), "UInt", Flags_, "Str", Out_, "UInt*", &Out_Len, "Ptr", 0, "Ptr", 0)
    return Out_Len
}

LC_Base64_Decode_2_bin(Text_, Encoding_ := "UTF-8")
{
    Len_ := LC_Base64_Decode(&Bin_, &Text_)
    return StrGet(StrPtr(Bin_), Len_)
}
inputString := "AgGqtgAA"
result := LC_Base64_Decode_2_bin(inputString)

A_Clipboard := result ; Ă뚪

bin2dec := (n) => (StrLen(n) > 1 ? bin2dec(SubStr(n, 1, -1)) << 1 : 0) | SubStr(n, -1)

MsgBox Format('0x{:X}', bin2dec('%result%'))