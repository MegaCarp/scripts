#Requires AutoHotkey v2.0
#Include utils\defaults-gw2.ahk


DragTradingPostToWorkingPosition() {
    GoToGw2

    BlockInput 'MouseMove'
    Send "{LButton down}"
    w8 100
    MouseMove X := 1321, Y := 58 ; point to drag the tp to
    Send "{LButton up}"
    BlockInput "MouseMoveOff"
}

SetUpTpWorkingTabs() {
    GoToGw2

    Click X := 1231, Y := 144 ; my transactions
    w8
    Click X := 505, Y := 368 ; history tab, to reset
    w8
    Click X := 513, Y := 263 ; current transactions
    w8
    Click X := 476, Y := 296 ; buying
    w8
}

Map_QualityModes := Map()

Map_QualityModes["Basic"] := Map("Synonyms", Array(), "ExpectedOutput", '', "Coordinates", Array())
Map_QualityModes["Fine"] := Map("Synonyms", Array(), "ExpectedOutput", '', "Coordinates", Array())
Map_QualityModes["Masterwork"] := Map("Synonyms", Array(), "ExpectedOutput", '', "Coordinates", Array())
Map_QualityModes["Rare"] := Map("Synonyms", Array(), "ExpectedOutput", '', "Coordinates", Array())
Map_QualityModes["Exotic"] := Map("Synonyms", Array(), "ExpectedOutput", '', "Coordinates", Array())
Map_QualityModes["Ascended"] := Map("Synonyms", Array(), "ExpectedOutput", '', "Coordinates", Array())
Map_QualityModes["Legendary"] := Map("Synonyms", Array(), "ExpectedOutput", '', "Coordinates", Array())

Map_QualityModes["Basic"]["Synonyms"] := ["Basic", "B", "1"]
Map_QualityModes["Basic"]["ExpectedOutput"] := ["Basic, B, 1"]
Map_QualityModes["Basic"]["Coordinates"] := [526, 313]

Map_QualityModes["Fine"]["Synonyms"] := ["Fine", "F", "2"]
Map_QualityModes["Fine"]["ExpectedOutput"] := ["Fine, F, 2"]
Map_QualityModes["Fine"]["Coordinates"] := [521, 333]

Map_QualityModes["Masterwork"]["Synonyms"] := ["Masterwork", "M", "3"]
Map_QualityModes["Masterwork"]["ExpectedOutput"] := ["Masterwork, M, 3"]
Map_QualityModes["Masterwork"]["Coordinates"] := [507, 364]

Map_QualityModes["Rare"]["Synonyms"] := ["Rare", "R", "4"]
Map_QualityModes["Rare"]["ExpectedOutput"] := ["Rare, R, 4"]
Map_QualityModes["Rare"]["Coordinates"] := [505, 393]

Map_QualityModes["Exotic"]["Synonyms"] := ["Exotic", "E", "5"]
Map_QualityModes["Exotic"]["ExpectedOutput"] := ["Exotic, E, 5"]
Map_QualityModes["Exotic"]["Coordinates"] := [503, 421]

Map_QualityModes["Ascended"]["Synonyms"] := ["Ascended", "A", "6"]
Map_QualityModes["Ascended"]["ExpectedOutput"] := ["Ascended, A, 6"]
Map_QualityModes["Ascended"]["Coordinates"] := [506, 440]

Map_QualityModes["Legendary"]["Synonyms"] := ["Legendary", "L", "7"]
Map_QualityModes["Legendary"]["ExpectedOutput"] := ["Legendary, L, 7"]
Map_QualityModes["Legendary"]["Coordinates"] := [510, 465]

for id, value IN Map_QualityModes["Exotic"]["Synonyms"]
MsgBox value


FilterForQuality(Mode) {

    for key, value IN Map_QualityModes
        for key, value IN Map_QualityModes["Synonyms"] {
            
        }


        if RegExMatch(value, "")
    switch Mode, 0 {
        case RegExMatch() :
            
        default:
            
    }
    GoToGw2

    Click X := 620, Y := 223 ; settings and filters
    w8
    Click X := 574, Y := 263 ; open filters
    w8
    Click X := 526, Y := 313 ; basic
    w8
}