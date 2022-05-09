# Image


## Display images in terminal (iTerm2)

iTerm2 has a protocol to display images:

- `ESC ] 1337 ; key = value ^G`
- `printf "\033]1337;File="`


In practice, iTerm2 has the `imgcat` command to display images.

```bash
imgcat path/to/image
cat path/to/image | imgcat
```

> Another option is using the kitty terminal with the `icat` command.


Display images inside a **python script** (source [link1](https://gist.github.com/antorsae/e4ddd00efb627eed5d8e41d023ee8394), [link2](https://github.com/antorsae/data-science-bowl-2018/blob/master/iterm.py)):

```python
# if you have iterm2 for osx (www.iterm2.com) this is a like print(...) for images in the console

import base64
import io
import numpngw
import numpy as np

def show_image(img):
    if img.dtype != np.uint8:
        print("ERROR: Should be an uint8 numpy array") 
    png_array = io.BytesIO()
    numpngw.write_png(png_array, img)
    encoded_png_array = base64.b64encode(png_array.getvalue()).decode("utf-8", "strict")  
    png_array.close()
    image_seq = '\033]1337;File=[width=auto;height=auto;inline=1]:'+encoded_png_array+'\007'
    print(image_seq, end='')
```




## LibJPEG-Turbo

Decode JPEG (very fast):

```bash
djpeg filename.jpg
```



## [ImageMagick](http://www.imagemagick.org/script/index.php)

| Command     | Description                         |
|-------------|-------------------------------------|
| `convert`   | convert and modify images           |
| `identify`  | Output information about this image |
| `mogrify`   | in-place batch processing           |
| `composite` | overlaying images in special ways   |
| `montage`   | generate grid of images             |
| `display`   | Slideshows of Images                | 
| `animate`   | Show GIF Animations                 | 
| `compare`   | Look for Differences                |
| `stream`    | Pipelined Image Processor           |
| `import`    | Read Images from On-screen Display  |
| `conjure`   | Experimental IM Scripting Language  |


## ImageMagick `convert`

Synopsis:
```bash
convert [input-options] input-file [output-options] output-file
# Specify 'file' as '-' for standard input or output.
```

## Conversion between formats

- `convert imagen.jpg imagen.png`: Convertir una imagen de png a jpg
- `convert imagen.{png,jpg}`: Same of before using Expansion.

## Resizing `convert -resize`

- `convert IN_IMG -resize 64x64 OUT_IMG`     Resize image (set larger to 64px)
- `convert IN_IMG -resize 64x64\! OUT_IMG`   Resize image (Ignore Aspect Ratio)

## Cropping `convert -crop`

- `convert IN_IMG -crop 703x470+3+5 OUT_IMG` Crop image with *width x height + left + top* format


## Generate grid of images: `montage`

```bash
# Sytntax:
montage INPUT_IMGS [OPTIONS] OUTPUT_IMG

# Examples:
montage imgs/* grid.png   # Generate and save grid
montage imgs/* - | imgcat # Generate grid to stdout and display it with imgcat
montage imgs/* -geometry 100x100\>+2+2 - | imgcat # Define size (100x100pxs) & margin (2px) of images
```

![](../img/imagemagick_montage.jpeg)







