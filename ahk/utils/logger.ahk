#Requires AutoHotkey v2.0
#Include defaults-global.ahk
/**
 * @description Class provides an instance of an object dedicated to writing logs to a variable in an easy-to-use way.
 * 
 * Logs are stored in an ArrayOfArrays where
 *              [1] is Log Level 
 *              [2] is Log Entry 
 * This allows for easy log trimming and printing.
 * 
 * Be aware that Logger and InputChecker are interdependent!
 * 
 * Class has methods for:
 * - Trimming logs to protect against recursion.
 * - Concatenating the ArrayOfArrays into a string.
 * - Appending or replacing with the current string to a file.
 * - Ingesting a log file and appending or prepending it for current logs.
 *
 * Class has properties for:
 * - LogLevel
 *      - Used by Trim to decide to what Log Level to trim the current Log.
 */
class Logger extends Object {

    __New(LogLevel := 'FATAL', LogFilePath := "Default") {

        this.LogArray := Array
        this.LogString := ''
        this.Testing := ''

        if LogFilePath = "Default" {
            this.LogFilePath := A_MyDocuments "\scripts\ahk\logs\" this.GetName("_boot.txt")
        } else {
            this.LogFilePath := LogFilePath
        }

        if FileExist(LogFilePath) = '' {

            this.Log("LogFile doesn't exist, file created.")

        }

    }
/**
 * 
 * @param {
 *          'SILENT' 
 *          'FATAL' 
 *          'ERROR' 
 *          'WARN' 
 *          'INFO' 
 *          'DEBUG'
 *          'TRACE' 
 *          'LINEBREAK' 
 *  } Level 
 * @param {String} Entry 
 */
    Log(Level, Entry) {
        FormatTime(, "dd_HH.mm.ss")

    }

    GetName(postfix := '', UseLast := 'Yes') {

        static TheLast := ''

        if UseLast != 'Yes' OR !TheLast
            TheLast := FormatTime(, "yy-MM-dd_HH.mm.ss") postfix

        return TheLast

    }

    ; Log(Text, isError := "No", prefix := '', postfix := '', Image := '', Debug := this.Debug) {

    ;     Time := ''
    ;     addErr := ''
    ;     if NOT isError = "No" {
    ;         Time := 4000
    ;         addErr := "Err! "
    ;     }

    ;     timestamp := FormatTime(, "HH:mm:ss")
    ;     TotalString := addErr timestamp "      " this.ProcessTree ", Debug = " this.Debug prefix Text postfix Image

    ;     MsgBox this.LogFilePath

    ;     FileAppend TotalString, this.LogFilePath
    ;     if Debug > 1 {
    ;         MsgBox TotalString
    ;     }
    ; }
}
