#Requires AutoHotkey v2.0
#Include defaults-global.ahk

class GetUserInput extends Gui {
    __New(FunctionToExecute := '') {
        this.Gui := Gui()
        this.TextField := this.Gui.AddEdit("-WantReturn", "Leave empty to cancel")
        this.okButton := this.Gui.AddButton('Default', "Ok")

        this.FunctionToExecute := FunctionToExecute

    }

    getInput() {

        this.Gui.Show
        this.TextField.Focus()
        Send "{Control down}a{Control up}"

        if !this.FunctionToExecute {
            this.TextField.OnEvent("LoseFocus", JustHideGui)
            this.okButton.OnEvent('Click', JustHideGui)
        } else {
            this.TextField.OnEvent("LoseFocus", this.FunctionToExecute)
            this.okButton.OnEvent('Click', this.FunctionToExecute)
        }

        JustHideGui(*) {
            this.Gui.Hide
        }
    }
}
