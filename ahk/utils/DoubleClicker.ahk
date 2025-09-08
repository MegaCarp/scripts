#Requires AutoHotkey v2.0
#SingleInstance Force

#Include defaults-global.ahk

/**
 * Does one doubleclick with Delay. 
 * 
 * If it's intended to Click a lot then default setting will provide Delay after the second click as well.
 */
DoubleClicker(Delay, Repeatable := 'Yes') {
    Click
    Sleep Delay
    Click
    if Repeatable = 'Yes'
        Sleep Delay
}
