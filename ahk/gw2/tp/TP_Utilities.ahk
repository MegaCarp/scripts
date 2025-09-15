#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ..\utils\defaults-gw2.ahk

Esc:: ExitApp

MouseGetPos &Coord_X, &Coord_Y
TP_Utilities_func Coord_X, Coord_Y

TP_Utilities_func(Coord_X, Coord_Y) {

    static TPU_CraftingLevellingSetup_ID := ''

    TPU_DoubleClicker(*) {
        TP_Utilities.Destroy
        GoToGw2
        Gw2_DoubleClicker(Coord_X, Coord_Y)
    }

    TPU_DoubleClickerFast(*) {
        TP_Utilities.Destroy
        GoToGw2
        Gw2_DoubleClicker(Coord_X, Coord_Y, 30)
    }

    TPU_ForgeAndFill(*) {
        TP_Utilities.Destroy
        GoToGw2
        ForgeAndFill(Coord_X, Coord_Y)
    }

    TPU_CraftingLevellingSetup(*) {
        TP_Utilities.Destroy
        GoToGw2
        Run 'crafting levelling setup.ahk', , , &TPU_CraftingLevellingSetup_ID
    }

    TPU_CraftingLevellingSetup_TurnOff(*) {
        TP_Utilities.Destroy
        GoToGw2
        ProcessClose TPU_CraftingLevellingSetup_ID
        TPU_CraftingLevellingSetup_ID := ''
    }

    TP_Utilities := Gui('AlwaysOnTop -Caption')
    TP_Utilities.AddButton('Default', 'DoubleClicker').OnEvent('Click', TPU_DoubleClicker)
    TP_Utilities.AddButton(, 'Forge and Fill').OnEvent('Click', TPU_ForgeAndFill)
    ; if TPU_CraftingLevellingSetup_ID = '' {
        TP_Utilities.AddButton(, 'Crafting levelling KBDs').OnEvent('Click', TPU_CraftingLevellingSetup)
    ; } else {
        TP_Utilities.AddButton(, 'kill Crafting levelling KBDs').OnEvent('Click', TPU_CraftingLevellingSetup_TurnOff)
        TP_Utilities.AddButton(, 'Fast Double Click').OnEvent('Click', TPU_DoubleClickerFast)
    ; }
    TP_Utilities.Show()

    ControlGetPos &xout, &yout, , , 'Forge and Fill', TP_Utilities
    MouseMove xout + 20, yout + 10, 0

}
