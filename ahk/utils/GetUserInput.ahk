#Requires AutoHotkey v2.0
#Include defaults-global.ahk

GetUserInput() {
    GetUserInputGui := Gui()
    GetUserInputGui.TextField := GetUserInputGui.AddEdit("-WantReturn", "Leave empty to cancel")
    GetUserInputGui.okButton := GetUserInputGui.AddButton('Default', "Ok")

    GetUserInputGui.Show
    GetUserInputGui.TextField.Focus()
    Send "^a"

    GetUserInputGui.TextField.OnEvent("LoseFocus", AllDone)
    GetUserInputGui.okButton.OnEvent('Click', AllDone)

    AllDone(&OutputValue, *) {
        OutputValue := GetUserInputGui.TextField.Value
        GetUserInputGui.Destroy
    }
    while IsSet(OutputValue) = 0 
    {}

    return OutputValue
}
