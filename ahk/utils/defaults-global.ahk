#Requires AutoHotkey v2.0

#Include ..\..

#Include ahk\utils\local-vars.ahk

#Include ahk\lib\lib_runcmd.ahk
#Include ahk\lib\lib_dsvparser-ahk2.ahk
#Include ahk\lib\lib_mutex.ahk
#Include ahk\lib\JSON.ahk

#Include ahk\work\go-to-VDI.ahk

#Include ahk\utils\base-sleep-interval.ahk
#Include ahk\utils\TestableDataForSwitching.ahk
#Include ahk\utils\TestingSuite.ahk

; #Include SearchableImage.ahk

#Include ahk\utils\Screenshot.ahk
#Include ahk\utils\GetUserInput.ahk

#Include ahk\utils\record-mouse-position.ahk

#Include ahk\utils\logger.ahk
#Include ahk\utils\notification.ahk

#Include ahk\utils\ticksTimer.ahk

#Include ahk\utils\toggleNightlight.ahk

LogFileName := A_MyDocuments "\logs\ahk\" FormatTime(,"yyyy-MM-dd") ".txt"

screenshotUtility := "C:\Program Files (x86)\MiniCap\MiniCap.exe"
if !FileExist(screenshotUtility)
    MsgBox "Screenshot utility path is invalid! Path is `"" screenshotUtility " `""

msPaintExecutable := "C:\Program Files\WindowsApps\Microsoft.Paint_11.2503.381.0_x64__8wekyb3d8bbwe\PaintApp\mspaint.exe"
if !FileExist(msPaintExecutable)
    MsgBox "msPaintExecutable path is invalid! Path is `"" screenshotUtility " `""


; debug := 1
