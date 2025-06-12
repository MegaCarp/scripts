#Requires AutoHotkey v2.0

#Include ..\utils\defaults-gw2.ahk

class GraphicalVisualOnlyInterface {

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

    __New(PngAsString, HowToGetHere_Func, Preceding_FunctionsHowToGetHere_Array := []) {

        if FileExist(PngAsString)
            this.Anchor := PngAsString
        else {
            MsgBox "file " PngAsString " wasn't found!"
            return
        }

        if Type(HowToGetHere_Func) = "Function" {
            this.HowToGetHere := Preceding_FunctionsHowToGetHere_Array
            this.HowToGetHere.Push(HowToGetHere_Func)
        } else {
            MsgBox "HowToGetHere_Func is not a function!"
            return
        }
    }

    FindTheAnchor(Rectrangle_ArrayOf4 := [0, 0, A_ScreenWidth, A_ScreenHeight]) {
        ImageSearch &outx, &outy, Rectrangle_ArrayOf4[1], Rectrangle_ArrayOf4[2], Rectrangle_ArrayOf4[3],
            Rectrangle_ArrayOf4[4],
            this.Anchor
        this.AnchorCoords := [outx, outy]
    }

}

FromTransactionsSelectTop3Items() {
    for id, value IN [418, 481, 538] {
        loop 2 {
            Click X := 1361, Y := value ; open an item to sell
            w8 100
        }
    }
}

FindTPIcon(&OutCoords) {
    ImageSearch &outx, &outy, 0, 0, A_ScreenWidth, A_ScreenHeight, "C:\Users\stash\Documents\scripts\ahk\gw2\tp\tp.png"
    OutCoords := [outx, outy]
}

; ; GoToGw2
; FromTransactionsSelectTop3Items() {
;     for id, value IN [418, 481, 538] {
;         loop 2 {
;             Click X := 1361, Y := value ; open an item to sell
;             w8 100
;         }
;     }
; }

FromTransactionsCancelTop3Items() {
    loop 3 {
        Click X := 1361, Y := 433 ; open an item to sell
        w8 400
        Click X := 1361, Y := 433 ; open an item to sell
        w8 400
    }
}

SelectOneOutOf3RecentlyViewed(Number123) {
    Order := [748, 820, 877]
    Click X := 968, Y := Order[Number123]
}

Gw2Relist3BuyOrders() {
    loop 3 {
        Click X := 854, Y := 714 ; bottom buyer long name
        w8 500
        Click X := 871, Y := 691 ; bottom buyer short name
        w8 500
        MouseMove X := 859, Y := 700 ; mousemove on how much to buy long name
        loop 10 {
            Click 'WheelDown'
            w8 1
        }
        MouseMove X := 850, Y := 700 ; mousemove on how much to buy short name
        loop 10 {
            Click 'WheelDown'
            w8 1
        }
        MouseMove X := 872, Y := 573 ; buy button
        w8 500
        ; Click
        w8 500
        Click X := 1361, Y := 437 ; click off an item
        w8 300
    }
}
