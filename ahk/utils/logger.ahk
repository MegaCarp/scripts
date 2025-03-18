#Requires AutoHotkey v2.0
#Include defaults-global.ahk

class Logger extends Object {
    __New(ProcessTree, Debug := 0, LogFilePath := "Default") {

        this.LogStarterMessage := ''

        this.Debug := Debug
        this.debugInheritance := ''
        if this.Debug = 3 {
            this.debugInheritance := 2
            this.LogStarterMessage := "Debug level is 3! Debug Inheritance set to 2.`n" this.LogStarterMessage
        }

        this.ProcessTree := ProcessTree "\Logger"

        if LogFilePath = "Default" {

            this.LogFilePath := A_MyDocuments "\scripts\ahk\logs\" this.GetDate(, "_boot.txt")
            this.LogStarterMessage := "Creating the Logger with LogFilePath being the default " this.LogFilePath "`n" this
                .LogStarterMessage

        } else {

            this.LogFilePath := LogFilePath
            this.LogStarterMessage := "LogFilePath manually set as " this.LogFilePath "`n" this.LogStarterMessage

        }

        if NOT FileExist(LogFilePath) = '' {

            this.Log("Writing to existing file.  " this.LogStarterMessage, , " Self-Log ")

        } else {

            this.Log("LogFile doesn't exist, file created.  " this.LogStarterMessage, , " Self-Log ")

        }

    }

    GetDate(prefix := '', postfix := '') {
        return prefix FormatTime(, "yy-MM-dd_HH.mm.ss") postfix
    }

    GetTime(prefix := '', postfix := '') {
        return prefix FormatTime(, "HH:mm:ss") postfix
    }

    Log(Text, isError := "No", prefix := '', postfix := '', Image := '', Debug := this.Debug) {

        if Debug = 3 {
            debugInheritance := 2
            if this.debugInheritance = '' {
                this.Log := "Debug level for this Log event only is 3! Debug Inheritance set to 2.`n" this.LogStarterMessage
            }
        }

        if Debug > 0 {

            Time := ''

            if NOT isError = "No" {
                Time := 4000
            }

            this.notification := Notification(Text, Image, isError,, 2)
            this.notification.Show(Time)
        }

        addErr := ''
        if NOT isError = "No" {
            addErr := "Err! "
        }

        SplitPath(this.ProcessTree, , &Parents)
        ; FileAppend addErr this.GetTime() "      " Parents ", Debug " this.Debug prefix Text postfix Image, this.LogFilePath
        ;; TODO this systemically
        MsgBox addErr this.GetTime() "      " Parents ", Debug " this.Debug prefix Text postfix Image this.LogFilePath
    }

}
