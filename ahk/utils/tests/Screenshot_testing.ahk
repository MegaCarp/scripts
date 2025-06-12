#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ..\Screenshot.ahk
testScreenReg := Screenshot(screenshotUtility, msPaintExecutable)
testScreenReg.ScreenshotRegion()