#Requires AutoHotkey v2.0
#Include defaults-global.ahk

/**
 * 
 * @description Creates an object that can be used to find and click a thing optionally visually on screen.  
 * @param {'[0, 0]'| Array} Coords_Arr  
 * - **Coords_Arr:** Where to click.  
 *   - If there's an image to search, then the coords are relative
 *   - Meant for there always be an Anchor.
 * @param {'200'|'0'|'800'| Integer} Delay  
 * - **Delay:** Delay in ms after the click needed for load.  
 *   - By default delay is 200 ms
 * @param {'c:\path\to\image.png'| String} Image  
 * - **Image:** Image file to search for, to click relationally.  
 *   - If set, the coords are meant to be relational rather than global.
 *   - Is optional.
 * @param {'[1000, 1000, 1200, 1200]'| Array} Rectangle  
 * - **Rectangle:** Rectangle to search the image in.  
 *   - By default will search the whole screen.
 *   - Is optional.
 * @returns {(Map)}  
 * - Result["Coords"] := [0, 0]
 * - Result["Delay"] := 200
 * - Result["ImageSearch"]["Image2Search"] := 'c:\path\to\image.png'
 * - Result["ImageSearch"]["Rectangle"] := '[1000, 1000, 1200, 1200]'
 * 
 * @example <caption></caption>  
 */
ClickData_builderUtility(Coords_Arr, Delay := 200, Image := '', Rectangle := [0, 0, A_ScreenWidth, A_ScreenHeight]) {

    Result := Map()
    Result["Coords"] := ''
    Result["Delay"] := ''
    Result["ImageSearch"] := Map()
    Result["ImageSearch"]["Image2Search"] := ''
    Result["ImageSearch"]["Rectangle"] := ''

    switch {

        case Type(Coords_Arr) != "Array":
        {
            MsgBox "Coords_Arr is not an Array!"
            return
        }

        case (Type(Coords_Arr[1]) != "Integer" OR Type(Coords_Arr[2]) != "Integer"):
        {
            MsgBox 'one of the Coords_Arr members is not an Integer!'
            return
        }

        case Coords_Arr[1].Length != 2:
        {
            MsgBox "Coords_Arr.Length is not 2!"
            return
        }

        default: Result["Coords"] := Coords_Arr

    }

    switch {
        case Type(Delay) != "Integer":
        {
            MsgBox 'Delay var is not an Integer!'
            return
        }

        default: Result["Delay"] := Delay
    }

    switch {
        case Type(Image) != 'String':
        {
            MsgBox "Image var is not a string!"
            return
        }

        case Image != '' AND !FileExist(Image):
        {
            MsgBox 'Image var is not empty but neither can the file be found!'
            return
        }

        default: Result["ImageSearch"]["Image2Search"] := Image
    }

    switch {
        case Type(Rectangle) != 'Array':
        {
            MsgBox "Rectangle var is not an Array!"
            return
        }

        case Rectangle.Count != 4:
        {
            MsgBox 'Rectangle needs to have 4 members!'
            return
        }

        case (Type(Rectangle[1]) != 'Integer' || Type(Rectangle[2]) != 'Integer' || Type(Rectangle[3]) !=
        'Integer' ||
        Type(Rectangle[4]) != 'Integer'):
        {
            MsgBox 'Rectangle is not populated with Integers!'
            return
        }

        case (Rectangle[1] > Rectangle[3] OR Rectangle[2] > Rectangle[4]):
        {
            MsgBox 'Rectangle coords are wrong!'
            return
        }

        default:
        {
            Result["ImageSearch"]["Rectangle"] := Rectangle
            ; HowToGetHere_ArrOfMaps[Iteration]["Coords"] := [coo, rds]
            ; HowToGetHere_ArrOfMaps[Iteration]["Delay"] := 200
            ; if there's a png - those are relative to imgsearch coords
            ; HowToGetHere_ArrOfMaps[Iteration]["ImageSearch"] := Map()
            ; HowToGetHere_ArrOfMaps[Iteration]["ImageSearch"]["Image2Search"] := "png/to/search.png"
            ; HowToGetHere_ArrOfMaps[Iteration]["ImageSearch"]["Rectangle"] := [re, ct, a, ngle]
        }

    }
    
    return Result

}

