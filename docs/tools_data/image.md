# Image [ImageMagick](http://www.imagemagick.org/script/index.php)

| Command   | Description                         |
|-----------|-------------------------------------|
| Convert   | convert and modify images           |
| Identify  | Output information about this image |
| Mogrify   | in-place batch processing           |
| Composite | overlaying images in special ways   |
| Montage   | generating arrays of thumbnails     |
| Display   | Slideshows of Images                | 
| Animate   | Show GIF Animations                 | 
| Compare   | Look for Differences                |
| Stream    | Pipelined Image Processor           |
| Import    | Read Images from On-screen Display  |
| Conjure   | Experimental IM Scripting Language  |


## iTerm2 `imgcat`

Display in the iTerm2 terminal

```bash
imgcat path/to/image
cat path/to/image | imgcat
```


## ImageMagick `convert`

Synopsis:
```bash
convert [input-options] input-file [output-options] output-file
# Specify 'file' as '-' for standard input or output.
```

### Conversion between formats

- `convert imagen.jpg imagen.png`: Convertir una imagen de png a jpg
- `convert imagen.{png,jpg}`: Using Expansion. Same of before.

### Resizing `convert -resize`

- `convert IN_IMG -resize 64x64 OUT_IMG`     Resize image (set larger to 64px)
- `convert IN_IMG -resize 64x64\! OUT_IMG`   Resize image (Ignore Aspect Ratio)

### Cropping `convert -crop`

- `convert IN_IMG -crop 703x470+3+5 OUT_IMG` Crop image with *width x height + left + top* format




## ImageMagick `montage`