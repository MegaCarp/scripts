#Requires AutoHotkey v2.0
#Include utils\defaults.ahk

#Include ..\lib\lib_base64ToBinToHex.ahk

; skill template: [&DQcBKi03OxvuFW4BBxaDAWUBgQHgFYoWRhftEgAAAAAAAAAAAAAAAAAAAAAAAA==]

; waypoint: [&BDgAAAA=]

foundChatLink := PrintChatLink(A_Clipboard)
if NOT (foundChatLink = "") {

    ; tester
    ; A_Clipboard := ("there is a chat link [&" foundChatLink "]") ; there is a chat link [&BDgAAAA=]

    chatLink2Hex := BinaryToHex(Base64ToBinary(foundChatLink))

    switch {

        ; is it a skill template?
        case RegExMatch(chatLink2Hex, "^0[dD]"):
        {

            ; A_Clipboard := ("it's a skill template [&" foundChatLink "]") ; there is a chat link [&BDgAAAA=]
            ; MsgBox ("it's a skill template [&" foundChatLink "]") ; there is a chat link [&BDgAAAA=]

            SendItToChat
            #IncludeAgain utils\chat\template\macro-open-a-template.ahk
            ; Click(Button := 'R', X := 219, Y := 1014) ; right click on pasted template
            ; w8
            ; ; Click X := 213, Y := 1013
            ; MouseMove X := 233, Y := 1049 ; open where to paste template picker
            ; w8
            ; MouseMove X := 431, Y := 1053 ; move to not close the template picker
            ; w8
            ; MouseMove X := 414, Y := 1020 ; prepick template 3
            #IncludeAgain utils\chat\template\go-to-build-template-3.ahk
        }

        case RegExMatch(chatLink2Hex, "^04"):
        {
            ; it's a map link, probably a waypoint
            SendItToChat
            Click X := 190, Y := 1010 ; LButton click in chat on the link following the nickname in the last
            w8(standardWaitTime + 900)
            Click X := 962, Y := 541 ; wait for map to show the wp then double click it
            Click
        }

        default: TrayTip "No link", "No chatlink found in A_Clipboard."

    }
} else {

    TrayTip "No link", "No chatlink found in A_Clipboard."

    ; tester
    ; MsgBox "no chat link" foundChatLink

}

PrintChatLink(aString) {

    ; checks whether there's a chat link in the input
    ; returns just that link, with padding removed - only base64 string
    ; if there are multiple links, will return only the first one

    startPosition := (RegExMatch(aString, "\[&[-A-Za-z0-9+/]*={0,3}]")) + 2
    endPosition := (RegExMatch(aString, "]", , startPosition)) - startPosition
    if NOT (startPosition = 2) {
        return SubStr(aString, startPosition, endPosition)
    }
}
