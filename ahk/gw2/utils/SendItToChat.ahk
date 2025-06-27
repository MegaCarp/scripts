#Requires AutoHotkey v2.0
#Include defaults-gw2.ahk

SendItToChat(Payload, WhichChatToSendTo := technicalGuildChat, prependWith := "", appendWith := '') {

    Payload := prependWith Payload appendWith

    Click X := 532, Y := 913 ; click outside chat so that if chat input is active, it'd deactivate
    w8
    Send "{Enter}"
    w8
    Send "^a"
    w8(standardWaitTime + 100)
    Send "^x" ; cut out whatever was written if anything into the clipboard
    w8
    Send "/" WhichChatToSendTo " "
    Send Payload
    Send "{Enter}"
    w8
    ; #IncludeAgain chat\open-technical-channel.ahk

}
