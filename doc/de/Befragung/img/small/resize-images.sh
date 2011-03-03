#!/bin/sh
#
# Convert images to a smaller size
for src in ../*.png
do
  bn=`basename $src`
  dst=`echo $bn | cut -d. -f1`.png
  convert $src -resize 50% $dst
done

