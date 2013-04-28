#!/bin/bash
PAGES=$(pdfinfo ${INPUT}.pdf | grep Pages | cut -d ":" -f 2 | sed 's/ //g')
INPUT=$(basename $1 .pdf)

# Bounding box parameter sequence
#
# Page:
# -----------
#   |   |   |
#-4-|---|-- |
#   1 # 3   |
#-2-|---|-- |
#   |   |   |
# -----------

#1. dia
pdfcrop --bbox '70 568 286 728' $1 outA.pdf
#2. dia
pdfcrop --bbox '310 568 526 728' $1 outB.pdf
#3. dia
pdfcrop --bbox '70 342 286 502' $1 outC.pdf
#4. dia
pdfcrop --bbox '310 342 526 502' $1 outD.pdf
#5. dia
pdfcrop --bbox '70 116 286 276' $1 outE.pdf
#5. dia
pdfcrop --bbox '310 116 526 276' $1 outF.pdf

pdftk A=outA.pdf B=outB.pdf C=outC.pdf D=outD.pdf E=outE.pdf F=outF.pdf shuffle A B C D E F output ${INPUT}_simple.pdf
pdftk ${INPUT}_simple.pdf cat 1-endW output ${INPUT}_kindle.pdf
rm -rf out*.pdf

