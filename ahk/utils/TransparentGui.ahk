#Requires AutoHotkey v2.0
#SingleInstance Force

#Include defaults-global.ahk


class TransparentGui extends Gui {
    __New(Name := '', Corner := '') {
        super.__New('AlwaysOnTop -SysMenu -Caption')
        WinSetTransparent(125, this)
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