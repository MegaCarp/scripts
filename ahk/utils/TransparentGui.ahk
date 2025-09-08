#Requires AutoHotkey v2.0
#SingleInstance Force

#Include defaults-global.ahk

class TransparentGui extends Gui {
    __New(
        Name := '',
        AppropriateWindow := '',
        Corner := ''
    ) {
        super.__New('AlwaysOnTop -SysMenu -Caption +Disabled', Name)
        WinSetTransparent(125, this)

        this.AppropriateWindow := WinGetID(AppropriateWindow)

        this.Corner := Corner
    }

    Show() {

        if this.Corner {
            WinGetPos , , &width, &height, this
            this.Corner := A_Space 'x' A_ScreenWidth - width - 367 A_Space 'y20'
        }

        SetTimer __ShowAndHide, 1000
        super.Show('NoActivate' this.Corner)

        __ShowAndHide() {
            if this.AppropriateWindow {
                MouseGetPos , , &id
                try {
                    if (id = this.AppropriateWindow) OR (id = WinGetID(this) OR (id = WinGetID('ahk_exe Blish HUD.exe'))) {
                        try {
                            this.Show
                            ; WinMoveBottom this
                        } catch {
                            try this.Hide
                        }
                    } else try this.Hide
                } catch {
                    try this.Hide
                }
            }
        }
    }

    TestOut() {

        if this.AppropriateWindow {
            MsgBox 'AppropriateWindow is set'

            MouseGetPos , , &id
            MsgBox id A_Space '=' A_Space WinGetID(this.AppropriateWindow)
            try {
                if (id = WinGetID(this.AppropriateWindow)) {
                    MsgBox 'this window is AppropriateWindow'
                } else MsgBox '!this window is not AppropriateWindow!'
            } catch {
                MsgBox 'either this is not an appropriate window or its time to hide anyway'
            }
        }

        this.AddText(, 'this gui is 35% transparent')

        this.Show()

        guiDestroy() {
            this.Destroy
        }
        SetTimer guiDestroy, -15000
    }

}
