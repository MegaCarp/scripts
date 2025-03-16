#Requires AutoHotkey v2.0
#Include defaults-global.ahk

class Logger extends Object {
    __New(ProcessName, Debug := 0, Parents := "None", LogFilePath :=
        "Default") {
        this.ProcessName := ProcessName

        if NOT Parents = "None" {
            this.ProcessParentsName := Parents
        }

        this.Debug := Debug

        if NOT LogFilePath = "Default" {

            this.LogFilePath := this.GetDate(, "_boot.txt")

        }

    }

    GetDate(prefix := '', postfix := '') {
        return prefix FormatTime(, "yy-MM-dd_HH.mm.ss") postfix
    }

    GetTime(prefix := '', postfix := '') {
        return prefix FormatTime(, "HH:mm:ss") postfix
    }

    Log(Text, isError := "No", prefix := '', postfix := '', Image := '', DitheredImage := '', Debug := this.Debug) {

        if Debug > 0 {

            Time := ''

            if NOT isError = "No" {
                Time := 4000
            }

            this.notification := Notification(Text, DitheredImage, Error)
            this.notification.Show(Time)
        }

        if NOT isError = "No" {
            addErr := "Err! "
        }

        FileAppend addErr this.GetTime() "      " prefix Text postfix Image, this.LogFilePath
    }

}
