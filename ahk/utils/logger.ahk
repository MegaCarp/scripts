#Requires AutoHotkey v2.0
#Include defaults-global.ahk

class Logger extends Object {
    __New(ProcessTree, Debug := 0, LogFilePath := "Default") {

        if Debug < 3 {
            this.Debug := Debug - 1
        } else {
            this.Debug := Debug
        }

        this.ProcessTree := ProcessTree

        if LogFilePath = "Default" {
            this.LogFilePath := A_MyDocuments "\scripts\ahk\logs\" FormatTime(, "yy-MM-dd_HH.mm.ss") "_boot.txt"
        } else {
            this.LogFilePath := LogFilePath
        }

        if FileExist(LogFilePath) = '' {

            this.Log("LogFile doesn't exist, file created.")

        }

    }

    Log(Text, isError := "No", prefix := '', postfix := '', Image := '', Debug := this.Debug) {

        Time := ''
        addErr := ''
        if NOT isError = "No" {
            Time := 4000
            addErr := "Err! "
        }

        timestamp := FormatTime(, "HH:mm:ss")
        TotalString := addErr timestamp "      " this.ProcessTree ", Debug = " this.Debug prefix Text postfix Image

        MsgBox this.LogFilePath

        FileAppend TotalString, this.LogFilePath
        if Debug > 1 {
            MsgBox TotalString
        }
    }
}
