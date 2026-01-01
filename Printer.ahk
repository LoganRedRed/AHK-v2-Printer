#Requires AutoHotkey v2.0
#SingleInstance Force

Esc::ExitApp

^1::
{
Sleep 1000

CoordMode("Mouse", "Screen")
CoordMode("Pixel", "Screen")

GetPixelXS := 524
GetPixelYS := 365

PaintPixelXS := 1296 ;1286
PaintPixelYS := 162 ;152

GetPixelX := GetPixelXS
GetPixelY := GetPixelYS

PaintPixelX := PaintPixelXS
PaintPixelY := PaintPixelYS

PreviousHex := ""

SendEvent "{RControl}"
Sleep 5000

loop
{

ColorHex := PixelGetColor(GetPixelX, GetPixelY, "Alt")
ColorHexArray := (StrSplit(ColorHex))
ColorRGBArray := [Number("0x" . ColorHexArray[3] . ColorHexArray[4]), Number("0x" . ColorHexArray[5] . ColorHexArray[6]), Number("0x" . ColorHexArray[7] . ColorHexArray[8])]

if(PreviousHex != ColorHex)
{
Click(2272, 82)
Sleep 100
Click(2125, 776)
Send("{Control down}{a}{Control up}")
Send(ColorRGBArray[1])
Click(2125, 800)
Send("{Control down}{a}{Control up}")
Send(ColorRGBArray[2])
Click(2125, 821)
Send("{Control down}{a}{Control up}")
Send(ColorRGBArray[3])
Send("{Enter}")

Sleep 100
}

Click(PaintPixelX, PaintPixelY)

GetPixelX := GetPixelX + 1
PaintPixelX := PaintPixelX + 1
PreviousHex := ColorHex

if(GetPixelX = (GetPixelXS + 200))
{
    GetPixelX := GetPixelXS
    PaintPixelX := PaintPixelXS
    GetPixelY := GetPixelY + 1
    PaintPixelY := PaintPixelY + 1
}
if(GetPixelY = (GetPixelYS + 200))
{
    break
}

}

Sleep 5000
SendEvent "{RControl}"

}