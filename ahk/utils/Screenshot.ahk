#Requires AutoHotkey v2.0
#Include defaults-global.ahk

; SplitPath(A_MyDocuments,, &outDir) ; C:\Users\Денис
class Screenshot {

    screenshotUtility := "C:\Program Files (x86)\MiniCap\MiniCap.exe"

    __New() {

        SplitPath A_MyDocuments, , &homeFolder
        this.MyDownloads := homeFolder "\Downloads\"
        this.defaultSavePath := this.MyDownloads "ahk-captured-image.png"
        this.defaultFileName := this.MyDownloads FormatTime(, "yy-MM-dd_HH.mm.ss")
        this.Extension := ".png"

    }

    defaultParameters := " -exit -save "

    ; ScreenshotScreen(Name := this.defaultFileName "_screen.png") {
    ;     MsgBox "C:\Program Files (x86)\MiniCap\MiniCap.exe" " -capturescreen" " -exit -save " A_MyDocuments FormatTime(, "yy-MM-dd_hh.mm.ss") "_screen.png"
    ; }

    ScreenshotScreen(SaveTo := this.defaultFileName "_screen") {
        RunWait this.screenshotUtility " -capturescreen" this.defaultParameters SaveTo this.Extension
    }

    ScreenshotSearchables(FileName := this.defaultFileName "_searchable", Size := 30) {
        MouseGetPos &Xcoordinates, &Ycoordinates

        ; TODO FileSelect()
        ScreenshotRegion()
        toggleNightlight()
        Sleep 3000
        ScreenshotRegion(2)
        toggleNightlight()

        ScreenshotRegion(Iteration := '') {

            ; -captureregion left top right bottom
            left := Ceil(Xcoordinates - Size / 2) " "
            top := Ceil(Ycoordinates - Size / 2) " "
            right := Ceil(Xcoordinates + Size / 2) " "
            bottom := Ceil(Ycoordinates + Size / 2) " "

            Region := " -captureregion " left top right bottom

            RunWait this.screenshotUtility Region this.defaultParameters FileName Iteration this.Extension
        }
    }

}

