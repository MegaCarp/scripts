#Requires AutoHotkey v2.0
#Include defaults-global.ahk

; w8()
; timeStart := A_TickCount
; if ImageSearch(&Found_close_windowX, &Found_close_windowY, 0, 0, A_ScreenWidth, A_ScreenHeight,
;     "night-light_x-close-window.png") {
;     ; if ImageSearch(&Found_close_windowX, &Found_close_windowY, 0, 0, A_ScreenWidth, A_ScreenHeight, "x-close-window.png") {
;     MsgBox "it took " A_TickCount - timeStart "ms"
;     ; MouseMove FoundX, FoundY
; } else {
;     MsgBox "nope"
; }

class ActWithImages {

    Debug := ''

    __New(Window := WinGetID("A")) {
        this.Window := Window
        ; CoordMode("Mouse", "Window")
    }

    MakeDithered(Image) {
        this.dithImage := TempDir "dith-" Image
        Run "magick " A_WorkingDir "\" Image " -colorspace gray -ordered-dither o8x8 " this.dithImage
    }

    UpdateWindowPosition() {
        WinGetPos(&outX, &outY, &outWidth, &outHeight, this.Window)
        this.Window.topLeftWindowCorner := [outX, outY]
        this.Window.Width := outWidth
        this.Window.Height := outHeight
    }

    FindTarget(
        Image,
        SearchAreaTopLeftCorner := this.Window.topLeftWindowCorner,
        SearchAreaBottomRightCorner := [this.Window.Width, this.Window.Height]
    ) {

        SearchRectangle := [SearchAreaTopLeftCorner, SearchAreaBottomRightCorner]
        if this.Window {
        }

        while (A_Index < 3) {

            if A_Index > 1 {
                WinMinimizeAll
            }

            if this.Window {
                WinActivate this.Window
            }

            if this.Debug {
                timeStart := A_TickCount
            }

            try
            {
                ImageSearch(&outX, &outY, SearchRectangle[1][1], SearchRectangle[1][2], SearchRectangle[2][1], SearchRectangle[2][2],
                    Image)

                if this.Debug {
                    debugNoti := Notification("To find the image it has taken" A_TickCount - timeStart "ms", Image)
                    debugNoti.Show()
                }

                MouseMove outX, outY
                this.TargetX := outX
                this.TargetY := outY

                if A_Index > 1 {
                    successAfterFailure := Notification("Found the image on " A_Index "nd try.", Image)
                    successAfterFailure.Show()
                }

            } catch {
                errorNoti := ErrorNotification("Couldn't find image.`nIteration № " A_Index, Image)
                errorNoti.Show()

                w8(250)
            }
        }
    }

    goto(Image) {
        if this.Window {
            WinActivate this.Window
        }

    }
}

; WinGetTitle
; testObs := ActWithImages()
; testObs.FindTarget("C:\Users\Денис\Documents\scripts\ahk\gw2\utils\img-search\night-light_x-close-window.png")
