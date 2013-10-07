#!/bin/bash
rm -rf "tempPDF$1"
echo "creating tempPDF"
mkdir "tempPDF$1"
echo "copying $1 to tempPDF$1"
cp "$1" "tempPDF$1"
echo "moving into tempPDF$1"
cd "tempPDF$1"
echo "extracting $1"
pdftk "$1" burst
for i in $( ls | grep pg); do
	echo "extracting $i"
  gs -sPAPERSIZE=a4 -sDEVICE=pnmraw -r300 -dNOPAUSE -dBATCH -sOutputFile=- -q $i | ocrad >> test.txt
done
echo "moving text file"
mv test.txt ../"$1.txt"
cd ..
rm -rf "tempPDF$1"
echo "done"
