### Parsing PDF: [`Xpdf`](https://www.xpdfreader.com) or [`poppler`](https://poppler.freedesktop.org)

- **Xpdf**: Viewer for Portable Document Format (PDF) files
	- `xpdf`: PDF viewer (click for a screenshot)
	- `pdftotext`: converts PDF to text
	- `pdftops`: converts PDF to PostScript
	- `pdftoppm`: converts PDF pages to netpbm (PPM/PGM/PBM) image files
	- `pdftopng`: converts PDF pages to PNG image files
	- `pdftohtml`: converts PDF to HTML
	- `pdfinfo`: extracts PDF metadata
	- `pdfimages`: extracts raw images from PDF files
	- `pdffonts`: lists fonts used in PDF files
	- `pdfdetach`: extracts attached files from PDF files
- **Poppler**: 	PDF rendering library based on xpdf
	- `pdfattach`
	- `pdfdetach`
	- `pdffonts`
	- `pdfimages`
	- `pdfinfo`
	- `pdfseparate`
	- `pdfsig`
	- `pdftocairo`
	- `pdftohtml`
	- `pdftoppm`
	- `pdftops`
	- **`pdftotext`**: Portable Document Format (PDF) to text converter
  	- `pdftotext [options] someFile.pdf`
	- `pdfunite`
- **MuPDF**
- **textutil**: Only in MacOS (Usado por Pascual Perez)
	- `textutil -convert txt ~/Desktop/DrectorioDeArchivosEnPDF/*.pdf`

|              | **Xpdf**              | **Poppler**                        | **MuPDF**                          |
|--------------|-----------------------|------------------------------------|------------------------------------|
| Installation | `sudo pacman -S xpdf` | `sudo pacman -S poppler`           | `sudo pacman -S mupdf-tools`       |
| PDF to text  |                       | `pdftotext -layout in.pdf out.txt` | `mutool convert -o out.txt in.pdf` |


```bash
for file in *.pdf; do pdftotext -layout "$file"; done
for file in *.pdf; do mutool convert -o $file.txt $file; done
```


## Parse with OCR!: `ocrmypdf`


# Documents

- `pandoc`: Conversion between markup formats
- `aspell`: A spell checker designed to eventually replace Ispell



https://programminghistorian.org/en/lessons/working-with-batches-of-pdf-files