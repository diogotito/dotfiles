#!/bin/sh

# Extracts a range of pages from a PDF file using GhostScript
#
# Usage:
#  - extract-pdf.sh <input_file>.pdf <first_page>-<last_page> <output_file>.pdf
#
# Example:
#  $ extract-pdf.sh INPUT.pdf 77-104 OUTPUT.pdf
#
# Alternatives to this script:
#  - Open your PDF in a graphical document viewer, then:
#     - Print -> Print to File (PDF) -> Pages (type the range)
#  - pdftk, pdfshuffler, qpdf, pdfseparate + pdfunite (avoid), etc.


input_file=$1
first_page=${2/-*/} # ou ${2%-*}
last_page=${2/*-/}  # ou ${2#*-}
#                           ^^^ como é que é suposto uma pessoa decorar isto?!
output_file=$3

gs  -sDEVICE=pdfwrite -dNOPAUSE -dBATCH   \
    -dFirstPage=$first_page               \
    -dLastPage=$last_page                 \
    -sOutputFile=$output_file             \
    $input_file
