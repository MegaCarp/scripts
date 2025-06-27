#Requires AutoHotkey v2.0
#Include defaults-global.ahk

class Screenshot {

    __New(screenshotUtility, msPaintExecutable) {

        this.screenshotUtility := screenshotUtility
        this.msPaintExecutable := msPaintExecutable

        SplitPath A_MyDocuments, , &homeFolder
        this.MyDownloads := homeFolder "\Downloads"
        this.defaultSavePath := this.MyDownloads
        this.Extension := ".png"

        this.DefaultImgSearchDirectory := A_MyDocuments "\scripts\ahk\gw2\utils\img-search"

    }

    GetName(postfix := '') {
        return FormatTime(, "yy-MM-dd_HH.mm.ss") postfix
    }

    defaultParameters := A_Space "-exit -save" A_Space

    FinalizeFilenameExtension(SaveToDir, FileSearch, FileName := this.GetName) {

        ; if you cancel the filesearch, it makes the screenshot anyway and saves it to a chronomically named .png into Downloads
        if FileSearch {
            ; FileName := FileSelect('S8', A_MyDocuments "\scripts\ahk\gw2\utils\img-search\test")
            FileName := FileSelect('S8', SaveToDir FileName)
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

    CheckFilenameExtension(FileName := '', FileSearch := '') {

        if !FileName
            return

        ; if you cancel the filesearch, it makes the screenshot anyway and saves it to a chronomically named .png into Downloads
        if FileSearch {
            ; FileName := FileSelect('S8', A_MyDocuments "\scripts\ahk\gw2\utils\img-search\test")
            FileName := FileSelect('S8', A_MyDocuments "\scripts\ahk\gw2\utils\img-search" FileName)
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
        SaveToDir := this.defaultSavePath,
        FileName := ''
    ) {

        if !FileName
            if this.lastFilename
                this.lastFilename := this.CheckFilenameExtension(FileSelect('S', this.lastFilename))
            else this.lastFilename := this.CheckFilenameExtension(FileSelect('S', this.defaultSavePath))

        PathWithNameAndExtension := this.FinalizeFilenameExtension(SaveToDir, FileName "_searchable", FileSearch)

        WinGetID("A")
        MouseGetPos &Xcoordinates, &Ycoordinates

        ; so originally it was thought that the nightlight affects the search
        ; additional testing gives doubt to this theory, so for now, i comment out the measures for nightlight toggle, etc
        ; TODO FileSelect()

        ; -captureregion left top right bottom
        left := Ceil(Xcoordinates - Size / 2)
        top := Ceil(Ycoordinates - Size / 2)
        right := Ceil(Xcoordinates + Size / 2)
        bottom := Ceil(Ycoordinates + Size / 2)

        this.lastRectangle := [left, top, right, bottom]

        WinActivate
        this._ScreenshotRegion('Yeah, open in Paint')

        ; ScreenshotRegion(1)
        ; toggleNightlight()
        ; Sleep 3000
        ; WinActivate LastWindow
        ; ScreenshotRegion(2)
        ; toggleNightlight()

    }
    /**
     * @description Works like Slurp, using a super simple GUI to show what's being saved. 
     * - Illustrates where the top left of the rectangle will be with a red dot.
     * - Uses MsgBox for controls and script pause.
     * @param {'home\Downloads\date_time-region.png'|String} Filename
     * - by default it saves to a hardcoded single file.
     * @param {'Yes'|String} OfferRename
     * - Anything but 'Yes' is a negation and the rename won't be asked about. 
     */
    ScreenshotRegion(Filename := '', OfferRename := 'Yes') {

        isThisADirectory := ''
        try isThisADirectory := InStr(FileGetAttrib(Filename), "D")

        if isThisADirectory {
            this.defaultSavePath := Filename
            Directory := Filename
        }
        else Directory := this.defaultSavePath

        if !(Filename)
            this.lastFilename := Directory '\' this.GetName('-region') ".png"
        else {
            this.lastFilename := this.CheckFilenameExtension(Filename)
            this.lastFilename := this.lastFilename[1] this.lastFilename[2]
        }

        MouseGetPos(&mouseX1, &mouseY1)
        redDot := Gui('+AlwaysOnTop -Caption +ToolWindow')
        redDot.BackColor := 'FF0000'
        redDot.Show('x' mouseX1 A_Space 'y' mouseY1 A_Space 'w3 h3')

        if MsgBox(
            'Move mouse to where the bottom right corner of the Rectangle will be and then select Yes to make the screenshot.`n`nYou can also select `'Cancel`' to cancel operation.', ,
            'OKCancel') = 'OK' {

            redDot.Destroy

            MouseGetPos(&mouseX2, &mouseY2)
            if (mouseX1 > mouseX2 OR mouseY1 > mouseY2) {
                MsgBox 'Incorrect Rectangle coordinates! The coordinates: ' mouseX1 A_Space mouseX2 A_Space mouseY1 A_Space mouseY2
                return
            }

            this.lastRectangle := [mouseX1, mouseY1, mouseX2, mouseY2]
            this._ScreenshotRegion("Open in Paint")

        } else {
            redDot.Destroy
            return
        }

        if OfferRename = 'Yes'
            this._AskForName(, 'Yeah, open in paint')
    }

    /**
     * @description Meant to be used as a tool for other functions.
     * @param {'c:\users\user\Downloads\gogo.png' | String} FileName
     * - Name for the output.
     * - By default saves into a hardcoded filename within Dowloads folder.
     * @param {'[100, 100, 200, 200]' | Array} Rectangle
     *  - Set the region to capture.
     *  - By default just captures the screen
     * @param {'No'|'1'|String} OpenPaint
     * - By default doesn't open msPaint to see the output.
     */
    _ScreenshotRegion(OpenPaint := 'No') {

        Rectangle := " -captureregion" A_Space this.lastRectangle[1] A_Space this.lastRectangle[2] A_Space this.lastRectangle[
            3] A_Space this.lastRectangle[
                4]

        RunWait this.screenshotUtility Rectangle this.defaultParameters this.lastFilename

        if OpenPaint != 'No'
            Run(this.msPaintExecutable A_Space this.lastFilename, ,
                'Min')
    }

    _AskForName(JustOpenFilePicker := 'No', OpenPaint := 'No') {
        if JustOpenFilePicker != 'No' OR MsgBox('Rename file?', , 'OKCancel') = 'OK' {
            RenameInto := this.CheckFilenameExtension(FileSelect('S', this.lastFilename))
            ; RenameInto := this.CheckFilenameExtension(FileSelect('S', this.DefaultImgSearchDirectory))

            if RenameInto {

                RenameInto := RenameInto[1] RenameInto[2]

                SplitPath this.lastFilename, &SansDir
                WinKill SansDir " - Paint"
                Sleep 20
                FileMove this.lastFilename, RenameInto, 1
                this.lastFilename := RenameInto

                if OpenPaint != 'No'
                    Run(this.msPaintExecutable A_Space this.lastFilename, ,
                        'Min')

            }
        }

    }
}

; testScreen := Screenshot()
; testScreen.ScreenshotSearchables()

; testScreen := Screenshot()
; testScreen.ScreenshotSearchables()
