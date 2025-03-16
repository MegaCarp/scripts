#Requires AutoHotkey v2.0
#Include defaults-global.ahk

; SplitPath(A_MyDocuments,, &outDir) ; C:\Users\Денис
class Screenshot {

    screenshotUtility := "C:\Program Files (x86)\MiniCap\MiniCap.exe"

    __New() {

        SplitPath A_MyDocuments, , &homeFolder
        this.MyDownloads := homeFolder "\Downloads\"
        this.defaultSavePath := this.MyDownloads
        this.Extension := ".png"

    }

    GetName(postfix := '') {
        return FormatTime(, "yy-MM-dd_HH.mm.ss") postfix
    }

    defaultParameters := " -exit -save "

    ; ScreenshotScreen(Name := this.defaultFileName "_screen.png") {
    ;     MsgBox "C:\Program Files (x86)\MiniCap\MiniCap.exe" " -capturescreen" " -exit -save " A_MyDocuments FormatTime(, "yy-MM-dd_hh.mm.ss") "_screen.png"
    ; }

    FinalizeFilenameExtension(SaveToDir, FileName, FileSearch) {

        ; if you cancel the filesearch, it makes the screenshot anyway and saves it to a chronomically named .png into Downloads
        if FileSearch {
            ; FileName := FileSelect('S8', "C:\Users\Денис\Documents\scripts\ahk\gw2\utils\img-search\test")
            FileName := FileSelect('S8', SaveToDir FileName)
        }

        if !FileName {
            FileName := this.GetName
        }

        ; if extension is doubled, remove the extension
        ; minicap docs: .jpg, .gif, .pdf, .png, .bmp, .tiff
        switch SubStr(FileName, StrLen(FileName) - 3) {
            case ".jpg":
                Extension := ".jpg"
                FileName := SubStr(FileName, 1, StrLen(FileName) - 4)
            case ".gif":
                Extension := ".gif"
                FileName := SubStr(FileName, 1, StrLen(FileName) - 4)
            case ".pdf":
                Extension := ".pdf"
                FileName := SubStr(FileName, 1, StrLen(FileName) - 4)
            case ".png":
                Extension := ".png"
                FileName := SubStr(FileName, 1, StrLen(FileName) - 4)
            case ".bmp":
                Extension := ".bmp"
                FileName := SubStr(FileName, 1, StrLen(FileName) - 4)
            case ".tiff":
                Extension := ".tiff"
                FileName := SubStr(FileName, 1, StrLen(FileName) - 4)

            default:
                Extension := ".png"
        }

        return [FileName, Extension]
    }

    ScreenshotScreen(SaveTo := this.defaultSavePath this.GetName "_screen") {
        RunWait this.screenshotUtility " -capturescreen" this.defaultParameters SaveTo this.Extension
    }

    ScreenshotSearchables(
        Size := 30,
        FileSearch := "Yes",
        Extension := this.Extension,
        SaveToDir := "C:\Users\Денис\Documents\scripts\ahk\gw2\utils\img-search\",
        FileName := this.GetName
    ) {

        PathWithNameAndExtension := this.FinalizeFilenameExtension(SaveToDir, FileName "_searchable", FileSearch)

        LastWindow := WinGetID("A")
        MouseGetPos &Xcoordinates, &Ycoordinates

        ; so originally it was thought that the nightlight affects the search
        ; additional testing gives doubt to this theory, so for now, i comment the measures for nightlight toggle, etc out
        ; TODO FileSelect()

        WinActivate LastWindow
        ScreenshotRegion()

        ; ScreenshotRegion(1)
        ; toggleNightlight()
        ; Sleep 3000
        ; WinActivate LastWindow
        ; ScreenshotRegion(2)
        ; toggleNightlight()

        ScreenshotRegion(IterationNum := '') {

            fullFileName := PathWithNameAndExtension[1] IterationNum PathWithNameAndExtension[2]

            ; -captureregion left top right bottom
            left := Ceil(Xcoordinates - Size / 2) " "
            top := Ceil(Ycoordinates - Size / 2) " "
            right := Ceil(Xcoordinates + Size / 2) " "
            bottom := Ceil(Ycoordinates + Size / 2) " "

            Region := " -captureregion " left top right bottom

            RunWait this.screenshotUtility Region this.defaultParameters fullFileName
            Run("C:\Windows\system32\mspaint.exe " fullFileName, , 'Min')
        }
    }

}

; testScreen := Screenshot()
; testScreen.ScreenshotSearchables()