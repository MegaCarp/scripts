#Requires AutoHotkey v2.0
#Include defaults-global.ahk

class Logger extends Object {
    __New(ProcessTree, Debug := 0, LogFilePath :=
        "Default") {

        this.Debug := Debug

        if NOT LogFilePath = "Default" {

            this.LogFilePath := this.GetDate(, "_boot.txt")

        }

        this.ProcessTree := ProcessTree

    }

    __Call(Name, Params) {
        
    }
    
    GetDate(prefix := '', postfix := '') {
        return prefix FormatTime(, "yy-MM-dd_HH.mm.ss") postfix
    }

    GetTime(prefix := '', postfix := '') {
        return prefix FormatTime(, "HH:mm:ss") postfix
    }

    Log(Text, isError := "No", prefix := '', postfix := '', Image := '', Debug := this.Debug) {

        if Debug > 0 {

            Time := ''

            if NOT isError = "No" {
                Time := 4000
            }

            this.notification := Notification(Text, Image, Error)
            this.notification.Show(Time)
        }

        addErr := ''
        if NOT isError = "No" {
            addErr := "Err! "
        }

        FileAppend addErr this.GetTime() "      " prefix Text postfix Image, this.LogFilePath
    }

}
