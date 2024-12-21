#Requires AutoHotkey v2.0
;;
; https://www.autohotkey.com/boards/viewtopic.php?f=82&t=134948&p=593537#p593537
; by just me (sic)

#Requires AutoHotkey v2.0

Base64ToBinary(Base64) { ; https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-cryptstringtobinaryw
   Static CRYPT_STRING_BASE64 := 0x00000001
   Local Size := 0
   If !(DllCall("Crypt32.dll\CryptStringToBinaryW", "Str", Base64,
                                                    "UInt", 0, 
                                                    "UInt", CRYPT_STRING_BASE64, 
                                                    "Ptr", 0, 
                                                    "UInt*", &Size, 
                                                    "Ptr", 0, 
                                                    "Ptr", 0))
      Throw OSError()
   Local Binary := Buffer(Size)
   If !(DllCall("Crypt32.dll\CryptStringToBinaryW", "Str", Base64,
                                                    "UInt", 0, 
                                                    "UInt", CRYPT_STRING_BASE64, 
                                                    "Ptr", Binary, 
                                                    "UInt*", &Size, 
                                                    "Ptr", 0, 
                                                    "Ptr", 0))
      Throw OSError()
   Return Binary 
}

BinaryToHex(Binary) { ; https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-cryptbinarytostringw
   Static CRYPT_STRING_HEX := 0x0000000C | 0x40000000 ; CRYPT_STRING_HEXRAW | CRYPT_STRING_NOCRLF
   Local Size := 0
   If !(DllCall("Crypt32.dll\CryptBinaryToStringW", "Ptr", Binary, 
                                                    "UInt", Binary.Size, 
                                                    "UInt", CRYPT_STRING_HEX, 
                                                    "Ptr", 0, 
                                                    "UInt*", &Size, 
                                                    "UInt"))
      Throw OSError()
   Local Hex := ""
   VarSetStrcapacity(&Hex, Size)
   If !(DllCall("Crypt32.dll\CryptBinaryToStringW", "Ptr", Binary, 
                                                    "UInt", Binary.Size, 
                                                    "UInt", CRYPT_STRING_HEX, 
                                                    "Str", &Hex, 
                                                    "UInt*", &Size, 
                                                    "UInt"))
      Throw OSError()
   Return StrUpper(Hex)
}

; A_Clipboard := BinaryToHex(Base64ToBinary("AgGqtgAA")) ; 0201AAB60000
