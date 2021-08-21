{*****************************************}
{                                         }
{                                         }
{     ModPlay - Component Free-For-All    }
{                                         }
{        Copyright (c) 2000 REDOX         }
{                                         }
{*****************************************}



unit ModPlay;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

const
BASS_OK			=0;
BASS_ERROR_MEM		=1;
BASS_ERROR_FILEOPEN	=2;
BASS_ERROR_DRIVER	=3;
BASS_ERROR_BUFLOST	=4;
BASS_ERROR_HANDLE	=5;
BASS_ERROR_FORMAT	=6;
BASS_ERROR_POSITION	=7;
BASS_ERROR_INIT		=8;
BASS_ERROR_START	=9;
BASS_ERROR_INITCD	=10;
BASS_ERROR_CDINIT	=11;
BASS_ERROR_NOCD		=12;
BASS_ERROR_CDTRACK	=13;
BASS_ERROR_ALREADY	=14;
BASS_ERROR_CDVOL	=15;
BASS_ERROR_NOPAUSE	=16;
BASS_ERROR_NOTAUDIO	=17;
BASS_ERROR_NOCHAN	=18;
BASS_ERROR_ILLTYPE	=19;
BASS_ERROR_ILLPARAM	=20;
BASS_ERROR_NO3D		=21;
BASS_ERROR_NOEAX	=22;
BASS_ERROR_DEVICE	=23;
BASS_ERROR_NOPLAY	=24;
BASS_ERROR_UNKNOWN	=-1;

BASS_DEVICE_8BITS	=1;
BASS_DEVICE_MONO	=2;
BASS_DEVICE_3D		=4;

type BASS_INFO=record
	size:DWORD;
	flags:DWORD;
	hwsize:DWORD;
	hwfree:DWORD;
	freesam:DWORD;
	free3d:DWORD;
	minrate:DWORD;
	maxrate:DWORD;
	eax:BOOL;
end;

const
DSCAPS_CONTINUOUSRATE	=$00000010;
DSCAPS_EMULDRIVER	=$00000020;
DSCAPS_CERTIFIED	=$00000040;
DSCAPS_SECONDARYMONO	=$00000100;
DSCAPS_SECONDARYSTEREO	=$00000200;
DSCAPS_SECONDARY8BIT	=$00000400;
DSCAPS_SECONDARY16BIT	=$00000800;


BASS_SLIDE_DIGITAL	=1;
BASS_SLIDE_CD		=2;

BASS_MUSIC_RAMP		=1;
BASS_MUSIC_RAMPS	=2;
BASS_MUSIC_LOOP		=4;
BASS_MUSIC_FT2MOD	=16;
BASS_MUSIC_PT1MOD	=32;
BASS_MUSIC_MONO		=64;
BASS_MUSIC_3D		=128;

type BASS_SAMPLE=record
	freq:DWORD;
	volume:DWORD;
	pan:INTeger;
	flags:DWORD;
	length:DWORD;
	max:WORD;

	mode3d:DWORD;
	mindist:single;
	maxdist:single;
	iangle:DWORD;
	oangle:DWORD;
	outvol:DWORD;
end;
const
BASS_SAMPLE_8BITS		=1;
BASS_SAMPLE_MONO		=2;
BASS_SAMPLE_LOOP		=4;
BASS_SAMPLE_3D			=8;
BASS_SAMPLE_SOFTWARE	=16;
BASS_SAMPLE_OVER_POS	=$20000;

type BASS_3DVECTOR=record
	x:single;
	y:single;
	z:single;
end;

const
BASS_3DMODE_NORMAL	=0;
BASS_3DMODE_RELATIVE	=1;

BASS_SYNC_MUSICPOS	=0;
BASS_SYNC_MUSICINST	=1;
BASS_SYNC_ONETIME	=$80000000;
CDCHANNEL	        =0;
type
  HMUSIC=DWORD;
  HSAMPLE=DWORD;
  HCHANNEL=DWORD;
  HSTREAMD=DWORD;
  HSYNC=DWORD;
  STREAMPROC=function(handle:HSTREAMD;buffer:INTeger;length:DWORD):DWORD;
  TModPlay = class(TCOMPONENT)

public

function BASS_GetVersion:DWORD;stdcall;
function BASS_GetDeviceDescription(devnum:INTeger;desc:char):BOOL;stdcall;
function BASS_ErrorGetCode:DWORD;stdcall;
function BASS_Init(device:INTeger;freq:DWORD;flags:DWORD;win:HWND):BOOL;stdcall;
procedure BASS_Free;stdcall;
procedure BASS_GetInfo(info:BASS_INFO);stdcall;
function BASS_GetCPU:DWORD;stdcall;
function BASS_Start:DWORD;stdcall;
function BASS_Stop:BOOL;stdcall;
function BASS_Pause:BOOL;stdcall;
function BASS_SetVolume(volume:DWORD):BOOL;stdcall;
function BASS_GetVolume:INTeger;stdcall;
function BASS_SlideVolume(volume:DWORD;period:DWORD;mode:DWORD):BOOL;stdcall;
function BASS_IsSliding:BOOL;stdcall;
function BASS_Set3DFactors(distf:single;rollf:single;doppf:single):BOOL;stdcall;
function BASS_Get3DFactors(distf:single;rollf:single;doppf:single):BOOL;stdcall;
function BASS_Set3DPosition(pos:BASS_3DVECTOR; vel:BASS_3DVECTOR; front:BASS_3DVECTOR; top:BASS_3DVECTOR):BOOL;stdcall;
function BASS_Get3DPosition(pos:BASS_3DVECTOR; vel:BASS_3DVECTOR; front:BASS_3DVECTOR; top:BASS_3DVECTOR):BOOL;stdcall;
function BASS_Apply3D:BOOL;stdcall;
function BASS_SetEAXParameters(env:INTeger;vol:single;decay:single;damp:single):BOOL;stdcall;
function BASS_GetEAXParameters(env:DWORD;vol:single;decay:single;damp:single):BOOL;stdcall;
function BASS_MusicLoad(filename:string;mem:BOOL;flags:DWORD):HMUSIC;stdcall;
procedure BASS_MusicFree(handle:HMUSIC);stdcall;
function BASS_MusicPlay(handle:HMUSIC):BOOL;stdcall;
function BASS_MusicPlayEx(handle:HMUSIC;pos:DWORD;flags:INTeger;reset:BOOL):BOOL;stdcall;
procedure BASS_MusicSetAmplify(handle:HMUSIC;amp:DWORD);stdcall;
procedure BASS_MusicSetPanSep(handle:HMUSIC;pan:DWORD);stdcall;
function  BASS_SampleLoad(filename:string;mem:BOOL;max:DWORD;flags:DWORD):HSAMPLE;stdcall;
procedure BASS_SampleFree(handle:HSAMPLE);stdcall;
function BASS_SampleGetInfo(handle:HSAMPLE; info:BASS_SAMPLE):BOOL;stdcall;
function BASS_SampleSetInfo(handle:HSAMPLE;info:BASS_SAMPLE):BOOL;stdcall;
function BASS_SamplePlay(handle:HSAMPLE):HCHANNEL;stdcall;
function BASS_SamplePlayEx(handle:HSAMPLE;start:DWORD;freq:INTeger;volume:INTeger;pan:INTeger;loop:BOOL):HCHANNEL;stdcall;
function BASS_SamplePlay3D(handle:HSAMPLE;pos:BASS_3DVECTOR;orient:BASS_3DVECTOR;vel:BASS_3DVECTOR):HCHANNEL;stdcall;
function BASS_SamplePlay3DEx(handle:HSAMPLE;pos:BASS_3DVECTOR;orient:BASS_3DVECTOR;vel:BASS_3DVECTOR;start:DWORD;freq:INTeger;volume:INTeger;loop:BOOL):HCHANNEL;stdcall;
function BASS_StreamCreate(freq:DWORD;flags:DWORD;proc:STREAMPROC):HSTREAMD;stdcall;
procedure BASS_StreamFree(handle:HSTREAMD);stdcall;
function BASS_StreamPlay(handle:HSTREAMD;flush:BOOL):BOOL;stdcall;
function BASS_CDInit(drive:char):BOOL;stdcall;
procedure BASS_CDFree;stdcall;
function BASS_CDInDrive:BOOL;stdcall;
function BASS_CDPlay(track:DWORD;loop:BOOL):BOOL;stdcall;
function BASS_ChannelIsActive(handle:DWORD):BOOL;stdcall;
function BASS_ChannelGetFlags(handle:DWORD):WORD;stdcall;
function BASS_ChannelStop(handle:DWORD):BOOL;stdcall;
function BASS_ChannelPause(handle:DWORD):BOOL;stdcall;
function BASS_ChannelResume(handle:DWORD):BOOL;stdcall;
function BASS_ChannelSetAttributes(handle:DWORD;freq:INTeger;volume:INTeger;pan:INTeger):BOOL;stdcall;
function BASS_ChannelGetAttributes(handle:DWORD;freq:DWORD;volume:DWORD;pan:INTeger):BOOL;stdcall;
function BASS_ChannelSet3DAttributes(handle:DWORD;mode:INTeger;min:single;max:single;iangle:INTeger;oangle:INTeger;outvol:INTeger):BOOL;stdcall;
function BASS_ChannelGet3DAttributes(handle:DWORD;mode:DWORD;min:single;max:single;iangle:DWORD;oangle:DWORD;outvol:DWORD):BOOL;stdcall;
function BASS_ChannelSet3DPosition(handle:DWORD;pos:BASS_3DVECTOR;orient:BASS_3DVECTOR;vel:BASS_3DVECTOR):BOOL;stdcall;
function BASS_ChannelGet3DPosition(handle:DWORD;pos:BASS_3DVECTOR;orient:BASS_3DVECTOR;vel:BASS_3DVECTOR):BOOL;stdcall;
function BASS_ChannelSetPosition(handle:DWORD;pos:DWORD):BOOL;stdcall;
function BASS_ChannelGetPosition(handle:DWORD):DWORD;stdcall;
function BASS_ChannelGetLevel(handle:DWORD):DWORD;stdcall;
function BASS_ChannelSetEAXMix(handle:DWORD;mix:single):BOOL;stdcall;
function BASS_ChannelGetEAXMix(handle:DWORD;mix:single):BOOL;stdcall;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TModPlay]);
end;
function TModPlay.BASS_GetVersion:DWORD; external 'BASS.DLL';
function TModPlay.BASS_GetDeviceDescription(devnum:INTeger;desc:char):BOOL;external 'BASS.DLL';
function TModPlay.BASS_ErrorGetCode:DWORD;external 'BASS.DLL';
function TModPlay.BASS_Init(device:INTeger;freq:DWORD;flags:DWORD;win:HWND):BOOL;external 'BASS.DLL';
procedure TModPlay.BASS_Free;external 'BASS.DLL';
procedure TModPlay.BASS_GetInfo(info:BASS_INFO);external 'BASS.DLL';
function TModPlay.BASS_GetCPU:DWORD;external 'BASS.DLL';
function TModPlay.BASS_Start:DWORD;external 'BASS.DLL';
function TModPlay.BASS_Stop:BOOL;external 'BASS.DLL';
function TModPlay.BASS_Pause:BOOL;external'BASS.DLL';
function TModPlay.BASS_SetVolume(volume:DWORD):BOOL;external 'BASS.DLL';
function TModPlay.BASS_GetVolume:INTeger;external 'BASS.DLL';
function TModPlay.BASS_SlideVolume(volume:DWORD;period:DWORD;mode:DWORD):BOOL;external 'BASS.DLL';
function TModPlay.BASS_IsSliding:BOOL;external 'BASS.DLL';
function TModPlay.BASS_Set3DFactors(distf:single;rollf:single;doppf:single):BOOL;external 'BASS.DLL';
function TModPlay.BASS_Get3DFactors(distf:single;rollf:single;doppf:single):BOOL;external 'BASS.DLL';
function TModPlay.BASS_Set3DPosition(pos:BASS_3DVECTOR; vel:BASS_3DVECTOR; front:BASS_3DVECTOR; top:BASS_3DVECTOR):BOOL;external 'BASS.DLL';
function TModPlay.BASS_Get3DPosition(pos:BASS_3DVECTOR; vel:BASS_3DVECTOR; front:BASS_3DVECTOR; top:BASS_3DVECTOR):BOOL;external 'BASS.DLL';
function TModPlay.BASS_Apply3D:BOOL;external 'BASS.DLL';
function TModPlay.BASS_SetEAXParameters(env:INTeger;vol:single;decay:single;damp:single):BOOL;external 'BASS.DLL';
function TModPlay.BASS_GetEAXParameters(env:DWORD;vol:single;decay:single;damp:single):BOOL;external 'BASS.DLL';
function TModPlay.BASS_MusicLoad(filename:string;mem:BOOL;flags:DWORD):HMUSIC;external 'BASS.DLL';
procedure TModPlay.BASS_MusicFree(handle:HMUSIC);external 'BASS.DLL';
function TModPlay.BASS_MusicPlay(handle:HMUSIC):BOOL;external 'BASS.DLL';
function TModPlay.BASS_MusicPlayEx(handle:HMUSIC;pos:DWORD;flags:INTeger;reset:BOOL):BOOL;external 'BASS.DLL';
procedure TModPlay.BASS_MusicSetAmplify(handle:HMUSIC;amp:DWORD);external 'BASS.DLL';
procedure TModPlay.BASS_MusicSetPanSep(handle:HMUSIC;pan:DWORD);external 'BASS.DLL';
function  TModPlay.BASS_SampleLoad(filename:string;mem:BOOL;max:DWORD;flags:DWORD):HSAMPLE;external 'BASS.DLL';
procedure TModPlay.BASS_SampleFree(handle:HSAMPLE);external 'BASS.DLL';
function TModPlay.BASS_SampleGetInfo(handle:HSAMPLE; info:BASS_SAMPLE):BOOL;external 'BASS.DLL';
function TModPlay.BASS_SampleSetInfo(handle:HSAMPLE;info:BASS_SAMPLE):BOOL;external 'BASS.DLL';
function TModPlay.BASS_SamplePlay(handle:HSAMPLE):HCHANNEL;external 'BASS.DLL';
function TModPlay.BASS_SamplePlayEx(handle:HSAMPLE;start:DWORD;freq:INTeger;volume:INTeger;pan:INTeger;loop:BOOL):HCHANNEL;external 'BASS.DLL';
function TModPlay.BASS_SamplePlay3D(handle:HSAMPLE;pos:BASS_3DVECTOR;orient:BASS_3DVECTOR;vel:BASS_3DVECTOR):HCHANNEL;external 'BASS.DLL';
function TModPlay.BASS_SamplePlay3DEx(handle:HSAMPLE;pos:BASS_3DVECTOR;orient:BASS_3DVECTOR;vel:BASS_3DVECTOR;start:DWORD;freq:INTeger;volume:INTeger;loop:BOOL):HCHANNEL;external 'BASS.DLL';
function TModPlay.BASS_StreamCreate(freq:DWORD;flags:DWORD;proc:STREAMPROC):HSTREAMD;external 'BASS.DLL';
procedure TModPlay.BASS_StreamFree(handle:HSTREAMD);external 'BASS.DLL';
function TModPlay.BASS_StreamPlay(handle:HSTREAMD;flush:BOOL):BOOL;external 'BASS.DLL';
function TModPlay.BASS_CDInit(drive:char):BOOL;external 'BASS.DLL';
procedure TModPlay.BASS_CDFree;external 'BASS.DLL';
function TModPlay.BASS_CDInDrive:BOOL;external 'BASS.DLL';
function TModPlay.BASS_CDPlay(track:DWORD;loop:BOOL):BOOL;external 'BASS.DLL';
function TModPlay.BASS_ChannelIsActive(handle:DWORD):BOOL;external 'BASS.DLL';
function TModPlay.BASS_ChannelGetFlags(handle:DWORD):WORD;external 'BASS.DLL';
function TModPlay.BASS_ChannelStop(handle:DWORD):BOOL;external 'BASS.DLL';
function TModPlay.BASS_ChannelPause(handle:DWORD):BOOL;external 'BASS.DLL';
function TModPlay.BASS_ChannelResume(handle:DWORD):BOOL;external 'BASS.DLL';
function TModPlay.BASS_ChannelSetAttributes(handle:DWORD;freq:INTeger;volume:INTeger;pan:INTeger):BOOL;external 'BASS.DLL';
function TModPlay.BASS_ChannelGetAttributes(handle:DWORD;freq:DWORD;volume:DWORD;pan:INTeger):BOOL;external 'BASS.DLL';
function TModPlay.BASS_ChannelSet3DAttributes(handle:DWORD;mode:INTeger;min:single;max:single;iangle:INTeger;oangle:INTeger;outvol:INTeger):BOOL;external 'BASS.DLL';
function TModPlay.BASS_ChannelGet3DAttributes(handle:DWORD;mode:DWORD;min:single;max:single;iangle:DWORD;oangle:DWORD;outvol:DWORD):BOOL;external 'BASS.DLL';
function TModPlay.BASS_ChannelSet3DPosition(handle:DWORD;pos:BASS_3DVECTOR;orient:BASS_3DVECTOR;vel:BASS_3DVECTOR):BOOL;external 'BASS.DLL';
function TModPlay.BASS_ChannelGet3DPosition(handle:DWORD;pos:BASS_3DVECTOR;orient:BASS_3DVECTOR;vel:BASS_3DVECTOR):BOOL;external 'BASS.DLL';
function TModPlay.BASS_ChannelSetPosition(handle:DWORD;pos:DWORD):BOOL;external 'BASS.DLL';
function TModPlay.BASS_ChannelGetPosition(handle:DWORD):DWORD;external 'BASS.DLL';
function TModPlay.BASS_ChannelGetLevel(handle:DWORD):DWORD;external 'BASS.DLL';
function TModPlay.BASS_ChannelSetEAXMix(handle:DWORD;mix:single):BOOL;external 'BASS.DLL';
function TModPlay.BASS_ChannelGetEAXMix(handle:DWORD;mix:single):BOOL;external 'BASS.DLL';
end.
