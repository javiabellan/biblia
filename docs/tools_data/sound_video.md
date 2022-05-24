# Sound

## `ffmepg`

Video and audio

- `ffmpeg -i input.mp4 output.avi` Convert audio format


## `sox`

**so**und e**x**change, the Swiss Army knife of audio manipulation.

- `play -n synth sin 1270 0.2 sin 1300 sin 1337 0.2 remix 1-3 repeat 0 vol 0.8 chorus 0.5 0.9 42 0.5 5 0.8 -t bandpass -c 1300 0.5q` # You can use sox to try to replicate the sound of the BroodX Cicadas using a mix of 3 tones around 1300 Hz.