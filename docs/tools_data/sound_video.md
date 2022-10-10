# Sound

## `ffmepg`

Video and audio

- `ffmpeg -i input.mp4 output.avi` Convert audio format


## `sox`

**so**und e**x**change, the Swiss Army knife of audio manipulation.

- `play -n synth sin 1270 0.2 sin 1300 sin 1337 0.2 remix 1-3 repeat 0 vol 0.8 chorus 0.5 0.9 42 0.5 5 0.8 -t bandpass -c 1300 0.5q` # You can use sox to try to replicate the sound of the BroodX Cicadas using a mix of 3 tones around 1300 Hz.



## Python OpenCV

```python
import cv2

cap = cv2.VideoCapture(0)

while(True):
    ret, frame = cap.read()   # Capture frame-by-frame. frame es nu nparray de 3 dims

    # Our operations on the frame come here...

    # Display the resulting frame
    cv2.imshow('frame',frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        cv2.destroyAllWindows()
        break

cap.release() # When everything done, release the capture (apagar la camara)
cv2.destroyAllWindows()
```
