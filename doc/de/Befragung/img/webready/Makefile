#
# This Makefile performs conversion from PDF files in the parent directory
# to PNG files, which have transparent background and certain size.
#
# You must have ImageMagick installed to perform conversions!

.SUFFIXES: .png .pdf

SRCDIR	= ..
DSTDIR	= .

.pdf.png:
	convert $< -transparent white -scale 40x40 $@

VPATH	= ${SRCDIR}

PDFS	= $(wildcard $(SRCDIR)/*.pdf)
PNGS	= $(patsubst $(SRCDIR)/%.pdf,$(DSTDIR)/%.png,$(PDFS))

all:	$(PNGS)

clean:
	rm -f *.png
