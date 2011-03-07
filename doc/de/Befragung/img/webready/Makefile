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

all: diag-down-left.png diag-down-left-up-right.png \
	diag-down-right.png diag-down-right-up-left.png \
	diag-up-left-down-right.png diag-up-left.png \
	diag-up-right-down-left.png diag-up-right.png \
	digit-1.png down-left.png down.png down-right.png \
	down-up-down.png down-up.png empty.png left-down.png \
	left.png left-right-left.png left-right.png left-up.png \
	letter-a.png multi-pinch-horizontal.png multi-pinch-vertical.png \
	multi-rotate-clockwise.png multi-rotate-counterclockwise.png \
	multi-spread-horizontal.png multi-spread-vertical.png \
	right-down.png right-left.png right-left-right.png right.png \
	right-up.png rotate-clockwise.png rotate-counterclockwise.png \
	up-down.png up-down-up.png up-left.png up.png up-right.png

