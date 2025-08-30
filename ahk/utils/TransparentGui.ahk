#Requires AutoHotkey v2.0
#SingleInstance Force

#Include defaults-global.ahk

class TransparentGui extends Gui {
    __New(
        Name := '',
        AppropriateWindow := '',
        Corner := ''
    ) {
        super.__New('AlwaysOnTop -SysMenu -Caption', Name)
        WinSetTransparent(125, this)

        this.AppropriateWindow := AppropriateWindow

    }

    __ShowAndHide() {
        if this.AppropriateWindow {
            try {
                if (WinGetProcessName("A") = this.AppropriateWindow) {
                    this.Show
                    WinMoveBottom this
                }
            } catch {
                this.Hide
            }
        }
    }

    Show() {
        super.Show
        SetTimer this.__ShowAndHide, 1000
    }

    TestOut() {
        this.AddText(, 'this gui is 35% transparent')

        this.Show()

        guiDestroy() {
            this.Destroy
        }
        SetTimer guiDestroy, -5000
    }

}
