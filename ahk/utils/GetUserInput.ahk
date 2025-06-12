#Requires AutoHotkey v2.0
#Include defaults-global.ahk

/**
 * @description Get text information from the user.
 * @param {"File name, please."|String} Prompt
 * - Prompt name.
 * @param {'Text already in the field, selected.'|String} DefaultText
 *  - This is the text that will be in the Edit field already.
 *  - If the default text is left in "Leave empty to cancel" and if it is that text that comes out of the function then it's annuled into ''
 */
GetUserInput(Prompt := '', DefaultText := 'Leave empty to cancel', Title := '', Options := "T10") {

    ; just a simple-ass wrapper to make it a oneliner for clarity

    InputBoxObj := InputBox(Prompt, Title, Options, DefaultText)

    if InputBoxObj.Value != "Leave empty to cancel" {
        return InputBoxObj.Value
    } else return ''
}
