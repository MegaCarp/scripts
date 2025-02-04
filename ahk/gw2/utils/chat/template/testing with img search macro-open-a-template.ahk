#Requires AutoHotkey v2.0

#IncludeAgain ..\right-click-on-template.ahk
w8
ImageSearch(&imgSrchX, &imgSrchY, X1 := "335", Y1 := "975", X2 := "102", Y2 := "1077", "apply-to-build-t.png")
w8
MouseMove imgSrchX, imgSrchY
; #IncludeAgain go-to-apply-to-build-template-opt-list.ahk
w8
; #IncludeAgain go-to-opts-list-w.o-closing-them.ahk
; #IncludeAgain go-to-build-template-3.ahk