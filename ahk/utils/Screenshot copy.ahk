#Requires AutoHotkey v2.0
#Include defaults-global.ahk

; testScreen := Screenshot()
; testScreen.ScreenshotSearchables()
    
; toggleNightlight()
; ; Sleep 3000
; ; toggleNightlight()

; FileName := "lala.png"
; FileNameExtensionCandidate := SubStr(FileName, 1, StrLen(FileName) - 4)

; MsgBox FileNameExtensionCandidate

; CheckOverTheFileName(SaveToDir, FileName, FileSearch) {

;     ; if you cancel the filesearch, it makes the screenshot anyway and saves it to a chronomically named .png into Downloads
;     if FileSearch {
;         ; FileName := FileSelect('S8', "C:\Users\Денис\Documents\scripts\ahk\gw2\utils\img-search\test")
;         FileName := FileSelect('S8', SaveToDir FileName)
;         MsgBox FileName
;     }
; }

; CheckOverTheFileName("C:\Users\Денис\Documents\scripts\ahk\gw2\utils\img-search\", "\test" "_searchable", 1)

; FileName := FileSelect('S8')

GetName() {
    return FormatTime(, "yy-MM-dd_HH.mm.ss")
}

MsgBox Type(GetName())
