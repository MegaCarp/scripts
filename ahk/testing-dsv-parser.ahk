#Requires AutoHotkey v2.0

#Include lib\dsvparser-ahk2.ahk

; csvFilePath := FileSelect(1, , "Select the CSV file to import your accounts from", "*.csv")
 
tsvFile := FileRead(A_MyDocuments "..\Downloads\Book1.txt")

myTable := TSVParser.ToArray(tsvFile)

MsgBox myTable[2][2]