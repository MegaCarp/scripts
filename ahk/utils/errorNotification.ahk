#Requires AutoHotkey v2.0
#Include defaults-global.ahk

errorNotification(Text, Image := '', logfile := A_MyDocuments "\logs\ahk\" FormatTime(, "yyyy-MM-dd") "\log.txt") {
 
    SplitPath(logfile, , &outDir) ; C:\Users\Денис
    fileName := outDir "\" FormatTime(, "hh-mm_") SubStr(Text, 1, 15)

    notification("Err! " Text, Image, logfile)

    screenshotScreen(fileName)

}
