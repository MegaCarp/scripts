#Requires AutoHotkey v2.0

#Include defaults-global.ahk

class QuerierWithButtons extends Gui {
    __New(ArrOfArrs_PairsButtonNameWithAFunction) {

        this.Error := Map()

        if Type(ArrOfArrs_PairsButtonNameWithAFunction) != "Array" {
            this.Error["Top Level Is Array"] := "Top-level of the parameter has to be an Array"
            return
        } else this.Error["Top Level Is Array"] := 1

        this.Error["Within The Array"] := []
        
        for id, value IN ArrOfArrs_PairsButtonNameWithAFunction {

            if Type(value) != "Array" {
                this.Error := "value №" A_Space id A_Space "is not an Array.`n Type of the value is" A_Space Type(value)
                return
            }

            if value.Length != 2
                this.Error := "Array №" A_Space id A_Space "has incorrect number of members`nNumber of elements:" A_Space value
                    .Length

            if Type(value[1]) != "String"
                this.Error := "Button name has to be a string"

            if Type(value[2]) != "Function"
                this.Error := "Button action has to be a function"

            this.AddButton(, value[1]).OnEvent('Click', value[2])

        }

    }

}
