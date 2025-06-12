#Requires AutoHotkey v2.0

#Include QuerierWithButtons.ahk

output := 0

; arrButtonsAndFuncs := [[1, SendOne], [2, SendTwo], [3, SendThree]]
; testQuery := QuerierWithButtons("lala")

test_QuerierWithButtons "will it return or not", "lala", "Top-level of the parameter has to be an Array"

; TestOutput("pressing button #1",,1)
; TestOutput("pressing button #2",,1)
; TestOutput("pressing button #3",,1)


test_QuerierWithButtons(WhatAreWeTesting, input, ExpectedOutput) {
    try testObject := QuerierWithButtons(input)
    TestOutput WhatAreWeTesting, testObject.Error, ExpectedOutput, "Show on pass"
}


SendOne(*) {
    return 1
}

SendTwo(*) {
    return 2
}

SendThree(*) {
    return 3
}

