#Requires AutoHotkey v2.0
#SingleInstance Force

Esc::ExitApp ; If you like being stuck waiting for it to finish with no method of escape, remove this.

^1:: ; You can change this to whatever you want, it's just my preference to start my scripts this way.
{
Sleep 1000

CoordMode("Mouse", "Screen")
CoordMode("Pixel", "Screen")

; This is the X and Y of the top left of where you want to scan.
GetPixelXS := 524
GetPixelYS := 365

; This is where the top left of the painting area in MSPaint is. If you're having trouble getting it right, the Window Spy tool in AHK can make it a lot easier.
PaintPixelXS := 1296 ;1286
PaintPixelYS := 162 ;152

GetPixelX := GetPixelXS
GetPixelY := GetPixelYS

PaintPixelX := PaintPixelXS
PaintPixelY := PaintPixelYS

PreviousHex := ""

;SendEvent "{RControl}" This is here because it made recording it easier.
;Sleep 5000

loop
{

; This gets the color information from the pixel, then converts the three color channels to an integer number so it can be intered into MSPaint later.
ColorHex := PixelGetColor(GetPixelX, GetPixelY, "Alt")
ColorHexArray := (StrSplit(ColorHex))
ColorRGBArray := [Number("0x" . ColorHexArray[3] . ColorHexArray[4]), Number("0x" . ColorHexArray[5] . ColorHexArray[6]), Number("0x" . ColorHexArray[7] . ColorHexArray[8])]

if(PreviousHex != ColorHex) ; This checks if the color is the same as the last pixel, and if it is, it skips the color setting process for that pixel.
{
Click(2272, 82) ; Set this to where the "Edit colors" button is.
Sleep 100
Click(2125, 776) ; Set this to where the Red input is.
Send("{Control down}{a}{Control up}")
Send(ColorRGBArray[1])
Click(2125, 800) ; Set this to where the Green input is.
Send("{Control down}{a}{Control up}")
Send(ColorRGBArray[2])
Click(2125, 821) ; Set this to where the Blue input is.
Send("{Control down}{a}{Control up}")
Send(ColorRGBArray[3])
Send("{Enter}")

Sleep 100
}

Click(PaintPixelX, PaintPixelY)

GetPixelX := GetPixelX + 1
PaintPixelX := PaintPixelX + 1
PreviousHex := ColorHex

if(GetPixelX = (GetPixelXS + 200)) ; This is how far left to right you want it to print (if you're printing something specific, you can just use it's resolution on the X axis).
{
    GetPixelX := GetPixelXS
    PaintPixelX := PaintPixelXS
    GetPixelY := GetPixelY + 1
    PaintPixelY := PaintPixelY + 1
}
if(GetPixelY = (GetPixelYS + 200)) ; This is how far top to bottom you want it to print (you can use the Y axis resolution here as well).
{
    break
}

}

;Sleep 5000
;SendEvent "{RControl}" This is so I could stop the recording without having to watch it the whole time.

}
