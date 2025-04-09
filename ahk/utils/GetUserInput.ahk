#Requires AutoHotkey v2.0
#Include defaults-global.ahk

GetUserInput(Prompt := '', DefaultText := 'Leave empty to cancel', Title := '', Options := "T10") {

    ; just a simple-ass wrapper to make it a oneliner for clarity

    InputBoxObj := InputBox(Prompt, Title, Options, DefaultText)

    if InputBoxObj.Value != "Leave empty to cancel" {
        return InputBoxObj.Value
    } else return ''
}
