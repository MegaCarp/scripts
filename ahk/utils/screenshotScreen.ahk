#Requires AutoHotkey v2.0
#Include defaults-global.ahk

; SplitPath(A_MyDocuments,, &outDir) ; C:\Users\Денис

screenshotScreen(screenshotToFile := "`"C:\Users\Денис\Downloads\image.png`"", screenshotUtility := "C:\Program Files (x86)\MiniCap\MiniCap.exe", screenshotParameters := " -capturescreen -exit -save ") {
    Run screenshotUtility screenshotParameters screenshotToFile
}