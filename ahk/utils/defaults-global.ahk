#Requires AutoHotkey v2.0

#Include ..\..

#Include ahk\utils\DoubleClicker.ahk

#Include ahk\utils\local-vars.ahk

#Include ahk\lib\lib_runcmd.ahk
#Include ahk\lib\lib_dsvparser-ahk2.ahk
#Include ahk\lib\lib_mutex.ahk
#Include ahk\lib\jsongo.v2.ahk
#Include ahk\lib\Peep.v2.ahk

#Include ahk\work\go-to-VDI.ahk

#Include ahk\utils\base-sleep-interval.ahk
#Include ahk\utils\TestableDataForSwitching.ahk
#Include ahk\utils\TestingSuite.ahk
#Include ahk\utils\HardLink.ahk

#Include ahk\utils\ClickData_builderUtility.ahk


; #Include ahk\utils\InputChecker.ahk
; #Include ahk\utils\logger.ahk

; #Include SearchableImage.ahk

#Include ahk\utils\Screenshot.ahk
#Include ahk\utils\GetUserInput.ahk

#Include ahk\utils\record-mouse-position.ahk

#Include ahk\utils\notification.ahk

#Include ahk\utils\ticksTimer.ahk

#Include ahk\utils\toggleNightlight.ahk

LogFileName := A_MyDocuments "\logs\ahk\" FormatTime(,"yyyy-MM-dd") ".txt"

screenshotUtility := "C:\Program Files (x86)\MiniCap\MiniCap.exe"
if !FileExist(screenshotUtility)
    MsgBox "Screenshot utility path is invalid! Path is `"" screenshotUtility " `""

msPaintExecutable := "C:\Users\stash\AppData\Local\Microsoft\WindowsApps\mspaint.exe"
if !FileExist(msPaintExecutable)
    MsgBox "msPaintExecutable path is invalid! Path is `"" screenshotUtility " `""


; debug := 1
