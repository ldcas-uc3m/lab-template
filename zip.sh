#!/bin/bash
# Bash script to zip the whole project in order to make it deriverable
# please make sure zip, pv and texlive are installed

OUTFILE=../outfile.zip


# compile the report (and save it to root folder)
echo "Compiling the report..."

latexmk -cd -shell-escape -pdf report/report.tex 

cp report/report.pdf .


cd src

# <clean stuff up>

cd ..

# zip it (excluding useless stuff)
echo "Zipping..."
zip -r $OUTFILE . -x zip.sh report/\* \*.git\* img/\* README.md

# cleanup
echo "Cleaning up..."
rm report.pdf
