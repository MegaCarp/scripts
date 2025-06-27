#Requires AutoHotkey v2.0
#SingleInstance Force

#Include defaults-global.ahk

class GraphicalVisualOnlyInterface {

    __New(PngForAnchor := '', DefaultDirectory := A_MyDocuments 'scripts\ahk\gw2') {

        this.Screenshotter := Screenshot(screenshotUtility, msPaintExecutable)

        this.Screenshotter.defaultSavePath FileSelect('D', DefaultDirectory)

        if FileExist(PngForAnchor)
            this.Anchor := PngForAnchor
        else {
            if PngForAnchor {
                MsgBox "file " PngForAnchor " wasn't found!"
            }

            this.Screenshotter.ScreenshotRegion()
        }

        SplitPath this.Anchor, &AnchorName
        this.AnchorName := AnchorName
        this.currentObjectFile := A_MyDocuments "\scripts\ahk\object-trail\" this.GetName '_' this.AnchorName '.json'

        SetTimer this.PrintOutTheObject, 5000

    }

    GetName(postfix := '') {
        return FormatTime(, "yy-MM-dd_HH.mm.ss") postfix
    }

    PrintOutTheObject() {
        FileAppend JSON.Dump(this, 1), this.currentObjectFile
    }

    this.MapOfCoordinatesData := Map()

    /**
     * @description Add a map of values to the map of maps for use by the object.
     * @param {'foo' | String} Name
     * The string that will be used as Key for the map for the data.
     * @param {[[0, 0], Delay := 200, Image := 'c:\path\to\image.png', Rectangle := [0, 0, A_ScreenWidth, A_ScreenHeight]] | Array} Data
     * Meant to be used automatically, extending the builder function to produce and add a data set to the map of maps variable.
     * @param {'No'|'anykey'| String} Overwrite
     * If a key exists, the function will error out - however with this flag set, it'll actually overwrite the key silently.
     */
    AppendNewDataToCoordinatesMap(Name, Data, Overwrite := 'No') {

        if Type(Name) != 'String' {
            MsgBox "key name needs to be a string!"
            return
        }

        if this.MapOfCoordinatesData.Has(Name) AND Overwrite = 'No' {
            MsgBox 'Name exsists in the object data already!'
            return
        }

        this.MapOfCoordinatesData.[Name] := ClickData_builderUtility(Data[1], Data[2], Data[3], Data[4])

    }

    FindTheAnchor(Rectrangle_ArrayOf4 := [0, 0, A_ScreenWidth, A_ScreenHeight]) {
        ImageSearch &outx, &outy, Rectrangle_ArrayOf4[1], Rectrangle_ArrayOf4[2], Rectrangle_ArrayOf4[3],
            Rectrangle_ArrayOf4[4],
            this.Anchor
        this.AnchorCoords := [outx, outy]
    }

}
