# ModPlay

A **Delphi VCL component** wrapping the **BASS.DLL** audio library, providing a drop-in component for playing tracker music modules (XM, IT, S3M, MOD), audio samples, streams, and CD audio with full 3D positional audio support.

![Delphi](https://img.shields.io/badge/Delphi-5%2F6%2F7-red)
![BASS](https://img.shields.io/badge/BASS.DLL-Audio-blue)
![Windows](https://img.shields.io/badge/Platform-Windows-0078D6)
![License](https://img.shields.io/badge/License-Freeware-green)

## Features

- **Tracker module playback** -- load and play XM, IT, S3M, and MOD files via `BASS_MusicLoad` / `BASS_MusicPlay`
- **Sample playback** -- load WAV/AIFF samples with `BASS_SampleLoad`, play with frequency, volume, and pan control
- **Stream creation** -- create custom audio streams via callback (`STREAMPROC`) for real-time audio generation
- **CD audio** -- initialize CD drive, detect disc presence, and play audio CD tracks
- **3D positional audio** -- full 3D sound positioning with `BASS_3DVECTOR` for position, orientation, and velocity
- **EAX environmental audio** -- set and query EAX reverb parameters (environment, volume, decay, damping)
- **Volume control** -- global volume get/set, smooth volume sliding with configurable period
- **Channel management** -- stop, pause, resume, set attributes (frequency, volume, pan) per channel
- **3D channel attributes** -- per-channel 3D mode, min/max distance, inner/outer cone angles
- **CPU usage monitoring** -- query BASS engine CPU usage
- **Device enumeration** -- query available audio devices and their capabilities
- **Error handling** -- comprehensive error codes for all failure conditions
- **VCL component** -- installs into the Delphi component palette under the "Samples" tab for drag-and-drop use

## Supported Audio Formats

| Format | Type | Description |
|--------|------|-------------|
| XM | Module | FastTracker 2 extended module |
| IT | Module | Impulse Tracker module |
| S3M | Module | Scream Tracker 3 module |
| MOD | Module | ProTracker / NoiseTracker module |
| WAV | Sample | Waveform audio |
| AIFF | Sample | Audio Interchange File Format |

## Dependencies

| Component | Purpose |
|-----------|---------|
| [BASS.DLL](https://www.un4seen.com/) | Audio engine (must be in the application directory or system PATH) |
| Delphi 5/6/7 | IDE and compiler |
| Windows | Target platform (DirectSound) |

## Installation

1. Copy `ModPlay.pas` into your Delphi project or component library directory.
2. In Delphi, open **Component > Install Component** and select `ModPlay.pas`.
3. The `TModPlay` component will appear on the **Samples** tab of the component palette.
4. Place `BASS.DLL` in your application's output directory.

## Usage

```pascal
// Initialize audio (44100 Hz, stereo, 16-bit)
ModPlay1.BASS_Init(-1, 44100, 0, Handle);

// Load and play a tracker module
var hMod: HMUSIC;
hMod := ModPlay1.BASS_MusicLoad('song.xm', False, BASS_MUSIC_LOOP);
ModPlay1.BASS_MusicPlay(hMod);

// Load and play a sample with 3D positioning
var hSam: HSAMPLE;
var hChan: HCHANNEL;
var pos: BASS_3DVECTOR;
hSam := ModPlay1.BASS_SampleLoad('shot.wav', False, 3, BASS_SAMPLE_3D);
pos.x := 1.0; pos.y := 0.0; pos.z := 5.0;
hChan := ModPlay1.BASS_SamplePlay3D(hSam, pos, pos, pos);

// Clean up
ModPlay1.BASS_MusicFree(hMod);
ModPlay1.BASS_SampleFree(hSam);
ModPlay1.BASS_Free;
```

## API Reference

The component exposes the full BASS 1.x API as class methods:

| Category | Key Methods |
|----------|------------|
| Init / System | `BASS_Init`, `BASS_Free`, `BASS_Start`, `BASS_Stop`, `BASS_Pause` |
| Volume | `BASS_SetVolume`, `BASS_GetVolume`, `BASS_SlideVolume` |
| Music | `BASS_MusicLoad`, `BASS_MusicPlay`, `BASS_MusicPlayEx`, `BASS_MusicFree` |
| Samples | `BASS_SampleLoad`, `BASS_SamplePlay`, `BASS_SamplePlay3D`, `BASS_SampleFree` |
| Streams | `BASS_StreamCreate`, `BASS_StreamPlay`, `BASS_StreamFree` |
| CD | `BASS_CDInit`, `BASS_CDPlay`, `BASS_CDFree`, `BASS_CDInDrive` |
| Channels | `BASS_ChannelStop`, `BASS_ChannelPause`, `BASS_ChannelResume`, `BASS_ChannelSetAttributes` |
| 3D Audio | `BASS_Set3DPosition`, `BASS_Set3DFactors`, `BASS_ChannelSet3DPosition` |
| EAX | `BASS_SetEAXParameters`, `BASS_GetEAXParameters` |
| Info | `BASS_GetVersion`, `BASS_GetCPU`, `BASS_GetInfo`, `BASS_ErrorGetCode` |

## Project Structure

```
modplay/
└── ModPlay.pas    # TModPlay VCL component -- BASS.DLL wrapper
```

## License

This project is provided as-is for educational purposes. BASS.DLL is copyright Un4seen Developments and requires a separate license for commercial use.
