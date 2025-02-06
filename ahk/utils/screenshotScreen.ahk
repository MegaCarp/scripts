#Requires AutoHotkey v2.0
#Include defaults-global.ahk

; SplitPath(A_MyDocuments,, &outDir) ; C:\Users\Денис

screenshotScreen(screenshotUtility := "C:\Program Files (x86)\MiniCap\MiniCap.exe", screenshotParameters := " -capturescreen -exit -save ", screenshotToFile := "`"C:\Users\Денис\Downloads\image.png`"") {
    Run screenshotUtility screenshotParameters screenshotToFile
}