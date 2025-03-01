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

    ScreenshotSearchables(FileName := this.defaultFileName "_searchable", Size := 30, Extension := this.Extension) {

        if !FileName {
            this.defaultFileName "_searchable"
        }

        FileNameExtensionCandidate := SubStr(FileName, StrLen(FileName) -4)
        if SubStr(StrLen(FileName))

        LastWindow := WinGetID("A")
        MouseGetPos &Xcoordinates, &Ycoordinates

        ; TODO FileSelect()
        WinActivate LastWindow
        ScreenshotRegion(1)
        toggleNightlight()
        Sleep 3000
        WinActivate LastWindow
        ScreenshotRegion(2)
        toggleNightlight()

        ScreenshotRegion(IterationNum := '') {

            fullFileName := FileName IterationNum this.Extension

            ; -captureregion left top right bottom
            left := Ceil(Xcoordinates - Size / 2) " "
            top := Ceil(Ycoordinates - Size / 2) " "
            right := Ceil(Xcoordinates + Size / 2) " "
            bottom := Ceil(Ycoordinates + Size / 2) " "

            Region := " -captureregion " left top right bottom

            RunWait this.screenshotUtility Region this.defaultParameters fullFileName
            Run("C:\Windows\system32\mspaint.exe " fullFileName,, 'Min')
        }
    }

}

testScreen := Screenshot()
testScreen.ScreenshotSearchables(FileSelect('S8'))