#Requires AutoHotkey v2.0
#Include defaults-global.ahk

GetUserInput(Prompt := '', Title := '', Options := '', DefaultText := '') {

    ; just a simple-ass wrapper to make it a oneliner for clarity

    InputBoxObj := InputBox(Prompt, Title, Options, DefaultText)

    if InputBoxObj.Value != DefaultText {
        return InputBoxObj.Value
    }
}
