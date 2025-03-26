#!/bin/bash
# Bash script to zip the whole project in order to make it deriverable
# please make sure zip and texlive are installed

set -e  # exit on error

OUTFILE=../outfile.zip
[ -e $OUTFILE ] && rm $OUTFILE  # remove if exists already


# compile the report (and save it to root folder)
echo "Compiling the report..."

latexmk -cd -shell-escape -silent -pdf report/report.tex 
cp report/report.pdf .


# zip it (excluding useless stuff)
echo "Zipping..."
zip -FS -r $OUTFILE . -x zip.sh report/\* \*.git\* img/\* \*__pycache__/\* \*.venv/\* \*build/\* .vscode/\* LICENSE README.md

# cleanup
echo "Cleaning up..."
rm report.pdf
