#include once "FBTrueType.bi"

' test of TTPrint with wstring

dim as integer maxw=640,maxh=480
screenres maxw,maxh,32
const fontfile = "DejaVuSans-Oblique.ttf"
chdir exepath()

' load the font
var font = FontLoad(fontfile)
if font<0 then
  print "error: loading: " & fontfile & " " & ErrorText(font)
  beep : sleep : end 1
end if

dim as wstring * 20 russian = "Привет, мир!"
dim as wstring * 20 greek   = "Καλημέρα κόσμε!"
dim as integer y=10
for i as integer = 0 to 11
  if i and 1 then
    TTPrint font,32,y,russian,rgb(i*16,128,255-i*16),16+i*4
  else
    TTPrint font,32,y,greek,rgb(i*16,128,255-i*16),16+i*4
  end if 
  y+=16+i*4
next
sleep
