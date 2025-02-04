#Requires AutoHotkey v2.0

; #IncludeAgain ..\right-click-on-template.ahk
; w8
; ImageSearch(&imgSrchX, &imgSrchY, X1 := "335", Y1 := "975", X2 := "102", Y2 := "1077", "apply-to-build-t.png")
; w8
; MouseMove imgSrchX, imgSrchY
; ; #IncludeAgain go-to-apply-to-build-template-opt-list.ahk
; ; w8
; ; #IncludeAgain go-to-opts-list-w.o-closing-them.ahk
; ; #IncludeAgain go-to-build-template-3.ahk

timeStart := A_TickCount
CoordMode "Pixel" ; Interprets the coordinates below as relative to the screen rather than the active window's client area.
ImageSearch(&imgSrchX, &imgSrchY, 1226, 563, 1437, 675, "C:\Users\Денис\Downloads\background-of-vscode-fake.png")
; ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, "C:\Users\Денис\Downloads\background-of-vscode.png")
if not (imgSrchX =  ''){
MouseMove imgSrchX, imgSrchY
}
MsgBox "it took " A_TickCount - timeStart "ms"