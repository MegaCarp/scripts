#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ..\utils\defaults-global.ahk


        WinActivate "ahk_exe Telegram.exe"
        w8()
            ImageSearch(&xout, &yout, 0, 0, A_ScreenWidth, A_ScreenHeight, "*50 *Trans366693 ..\tg-tester.png")
            MouseMove xout, yout
