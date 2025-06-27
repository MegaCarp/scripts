#Requires AutoHotkey v2.0
#SingleInstance Force

#Include ConditionalWindowManager.ahk

;; REMOVE
; SetTimer BlishVisibilityUtility, 5000

class GW2_ConditionalWindowManager extends ConditionalWindowManager {

    __New() {
        if FileExist(A_MyDocuments "..\games\gw2\blishud\Blish HUD.exe")
            this.BlishExe := A_MyDocuments "..\games\gw2\blishud\Blish HUD.exe"
        else if FileExist(A_MyDocuments "..\games\gw2\blishud\Blish HUD.exe")
            this.BlishExe := A_MyDocuments "..\games\gw2\addons\Blish HUD.exe"
        else MsgBox "Can't find Blish HUD! Here's where I looked: `n" A_MyDocuments "..\games\gw2\blishud\Blish HUD.exe`n" A_MyDocuments "..\games\gw2\addons\Blish HUD.exe"

        if FileExist("C:\games\GuildWars2-arenanet\Gw2-64.exe")
            this.Gw2Exe := "C:\games\GuildWars2-arenanet\Gw2-64.exe"
        else MsgBox "Can't find GW2! Here's where I looked: `nC:\games\GuildWars2-arenanet\Gw2-64.exe"

        super.__New(Gw2Exe, BlishExe)
    }

    PreTest() {
        tmp := this.WindowCondition
        this.WindowCondition := this.WindowCondition " -autologin"
        this.PreTest
        this.WindowCondition := tmp

        if this.WindowTest(this.WindowCondition)
            while A_Index < 13 OR LFIMG("C:\Users\stash\Documents\scripts\ahk\gw2\gw2-launched-marker.png")
                if ImageSearch(&xcoords, &ycoords, 0, 0, A_ScreenWidth, A_ScreenHeight,
                    "ahk\gw2\gw2-launched-play-button.png") {
                    Click xcoords, ycoords
                    Sleep 5000
                }

        LFIMG(Image) {
            return ImageSearch(&x, &y, 0, 0, A_ScreenWidth, A_ScreenHeight,
                "C:\Users\stash\Documents\scripts\ahk\gw2\gw2-launched-marker.png")
        }
    }

}
