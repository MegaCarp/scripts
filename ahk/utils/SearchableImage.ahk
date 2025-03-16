#Requires AutoHotkey v2.0
#Include defaults-global.ahk

class SearchableImage extends Object {

    __New(Image, Window := WinGetID("A")) {
        this.Window := Object()
        this.Window.ID := Window

        ; CoordMode("Mouse", "Window")

        this.UpdateWindowPosition

        this.FindTargetSuccess := ''

        this.Debug := ''

    }

    UpdateWindowPosition() {
        WinGetPos(&outX, &outY, &outWidth, &outHeight, this.Window.ID)
        this.Window.topLeftWindowCorner := [outX, outY]
        this.Window.Width := outWidth
        this.Window.Height := outHeight
    }

    FindTarget(
        SearchAreaTopLeftCorner := this.Window.topLeftWindowCorner,
        SearchAreaBottomRightCorner := [this.Window.Width, this.Window.Height]
    ) {

        SearchRectangle := [SearchAreaTopLeftCorner, SearchAreaBottomRightCorner]

        while ((A_Index < 3) OR this.FindTargetSuccess = '') {

            if A_Index > 1 {
                WinMinimizeAll
                w8
            }

            if this.Window.ID {
                WinActivate this.Window.ID
                w8
            }

            if this.Debug = 1 {
                timeStart := A_TickCount
            }

            try
            {
                ImageSearch(&outX, &outY, SearchRectangle[1][1], SearchRectangle[1][2], SearchRectangle[2][1],
                    SearchRectangle[2][2],
                    this.Image
                )

                this.FindTargetSuccess := 1

                if this.Debug = 1 {
                    debugNoti := Notification("To find the image it has taken" A_TickCount - timeStart "ms", this.ImageDithered
                    )
                    debugNoti.Show()

                    MouseMove outX, outY
                    this.TargetX := outX
                    this.TargetY := outY

                    if A_Index > 1 {
                        successAfterFailure := Notification("Found the image on " A_Index "nd try.", this.ImageDithered
                        )
                        successAfterFailure.Show()
                    }

                }

            } catch {
                errorNoti := ErrorNotification("Couldn't find image.`nIteration № " A_Index, this.ImageDithered)
                errorNoti.Show()

                w8(250)
            }
        }
    }

    goto() {
        if this.Window.ID {
            WinActivate this.Window.ID
        }

    }
}

; WinGetTitle
; testObs := ActWithImages()
; testObs.FindTarget("C:\Users\Денис\Documents\scripts\ahk\gw2\utils\img-search\night-light_x-close-window.png")
