#Requires AutoHotkey v2.0
#Include defaults-global.ahk

#Include SearchableImage.ahk

testImg := SearchableImage(A_MyDocuments "..\Downloads\Untitled.png")
testImg.Debug := 1
testImg.FindTarget()