#Requires AutoHotkey v2.0
#SingleInstance Force

/**
 * @description This function tests Data against ExpectedOutput according to the Mode of the launch.
 * 
 * Is meant to be used within the InputChecker_Wrapper.
 * 
 * Self-tests, using accordingly named Modes.
 * 
 * @param {String} Summary It's the first variable, due to how it makes the whole array more readable and helps with comprehension of what are you trying to achieve.
 * - It is used when formulating summary of a test.
 * @param { 
 *          'InputChecker_Input' 
 *          'InputChecker_Output' 
 *          'Type' 
 *          'ArrayOfArrays' 
 *          'InStr' 
 *          'Or' 
 *          'LogLevel' 
 *          'CriticalityLevel' 
 *  String | Integer} Mode 
 *  -   'InputChecker' modes are self tests, dedicated to checking over whether the input and the output parameters are valid for the tester Wrapper.
 *  -   'Type' mode will do Type(Data) against ExpectedResult
 *      - String
 *      - Float
 *      - Integer
 *      - Array
 *      - Map
 *      - Object
 *      - %ClassName%
 *  -   'ArrayOfArrays' mode will check whether Data is ArrayOfArrays
 *  -   'InStr' mode will check whether input is a String and then whether it contains ExpectedResult
 *  -   'Or' - ExpectedResult must be an Array of values - the test will check for that first.
 *           - There must be more than a single value within the Array.
 *           - It'll then test whether Data matches any value within the ExpectedResult
 *  -   'LogLevel' mode will check Data against an Array of appropriate Log Level values.
 *         - LogLevel has no principal difference with Notification Level.
 *          'SILENT' 
 *          '[SERVICE]' 
 *          'FATAL' 
 *          'ERROR' 
 *          'WARN' 
 *          'INFO' 
 *          'DEBUG'
 *          'TRACE' 
 *  -   'CriticalityLevel' mode will check Data against an Array of appropriate Criticality Level values.
 *          'CLEAR' 
 *          'FATAL' 
 *          'ERROR' 
 *          'WARN' 
 * @param {Any} Data For example this could be a function given over a variable - then this will be ensured using Type Mode.
 * @param {String | Integer} ExpectedResult This should be a 
 * @param {
 *          'SILENT' 
 *          '[SERVICE]' 
 *          'FATAL' 
 *          'ERROR' 
 *          'WARN' 
 *          'INFO' 
 *          'DEBUG'
 *          'TRACE' 
 *           String } NotificationLevel The value that decides when is the user to be informed.
 * - Defaults to SILENT - at this level, the function will be silent even after FATAL.
 * 
 * @returns {Map}
 *  The output will be a map of values, that can then be compared against the result and allow to decide what to do with the result.
 * 1. "Criticality level": 'CLEAR | FATAL | ERROR | WARN' | 
 *                          { String | Integer }
 *                              
 * 2. "Summary of the event", if any - can be empty, equalling to test being passed cleanly.
 * 3. "Log from the logger", if any.
 * 
 */
InputChecker(Summary, Mode, Data, ExpectedResult, NotificationLevel := 'SILENT') {

    InputChecker_mode([Summary, Mode, Data, ExpectedResult, NotificationLevel])

    InputChecker_mode(Array) {
        if Type_mode(Array, 'Array') = 'FATAL'
            return
    }

    Type_mode(Summary, Data, ExpectedResult, NotificationLevel) {
        if Type(Object) != ExpectedResult {

            ErrorLevel := 'FATAL'
            if NotificationLevel != 'SILENT'
                MsgBox 'Testing ' Summary 'failed'

            return 'FATAL'
        }
    }
}

/**
 * @description This is a wrapper for InputDataChecker, it's used in production code, post-draft of the development stage for code brevity and ease of use.
 * It iterates over the Array of the Arrays and runs a test for every Array, concatenating the output.
 * @param ArrayOfArrays Every array contains all the variables required for the InputDataChecker to function.
 * 
 * [Summary, Mode, Data, ExpectedResult, NotificationLevel := 'SILENT']
 * 
 * @param NotificationLevel At what level to raise a notification.
 * - Note that this defaults to FATAL - you have to manually set it to SILENT to stop it from bothering the user.
 * @returns {Map}
 * "Upper criticality level":
 *          'CLEAR' 
 *          'FATAL' 
 *          'ERROR' 
 *          'WARN' 
 * "Summary of the events": {String}
 * - Concatenates summaries of the events.
 * "Log": {String} 
 * - Concatenates the logs.
 */
InputChecker_Wrapper(ArrayOfArrays, NotificationLevel := 'FATAL') {
    Output := Array
    ; meant to be an Array of Maps due to the output of the InputChecker being a Map

    for id, value IN ArrayOfArrays
        Output.Push(InputChecker(value[1], value[2], value[3], value[4], value[5]))

    for id, value IN Output { ; TODO
        value["Upper criticality level"]
        value["Summary of the event"]
        value["Log from the logger"]
    }

}
