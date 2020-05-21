'  #######################################
' # fbs_soundobject_3d_set_position.bas #
'#######################################

' test of:
' fbs_Set_Position

'#include "../inc/fbsound.bi"
#include "../inc/fbsound_dynamic.bi"
#include "../inc/fbs3d.bi"

const data_path = "../data/"

' only if not same as exe path
' fbs_Set_PlugPath("./")

sub DrawObject(byref o as FBS_SOUNDOBJECT, _
               byval t as string         , _
               byval c as integer)
  dim as integer w,h,x,y
  if screenptr=0  then exit sub
  screeninfo w,h
  w shr=1:h shr=1
  x=w + o.pos.x
  y=h - o.pos.z
  circle (x,y),30,c,,,,f
  circle (x,y),30,7
  draw string step (-len(t)*4,-4),t 
  if (o.maxrange>0.0) then circle (x,y),o.maxrange,15
end sub

'
' main
'
dim as FBS_SOUNDOBJECT  listner
dim as FBS_SOUNDOBJECT  source
dim as single           volume,pan,oldVolume,oldPan,w
dim as integer          hWave,hSound,i
screenres 640,480
fbs_Init()
fbs_Load_WAVFile   (data_path & "pcar.wav",@hWave)
fbs_Create_Sound   (hWave,@hSound)
fbs_Set_SoundVolume(hSound,OldVolume)
fbs_Set_SoundPan   (hSound,OldPan)
fbs_Play_Sound     (hSound,100)



while inkey()=""
  fbs_Set_Position(source,cos(w)*300,0,10)
  screenlock:cls
    DrawObject(listner,"listner",1)
    DrawObject(source ,"source" ,2)
  screenunlock
  fbs_Get_VolumePan(@Volume,@Pan,listner,source)
  if (Volume<>OldVolume) or (Pan<>OldPan) then 
    if (Volume<>OldVolume) then fbs_Set_SoundVolume(hSound,Volume)
    if (Pan   <>OldPan   ) then fbs_Set_SoundPan   (hSound,Pan   )
    OldVolume=Volume:OldPan=Pan
  end if
  sleep 50
  w+=0.01
wend

