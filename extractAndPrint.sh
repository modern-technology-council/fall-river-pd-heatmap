#!/bin/bash
echo "extracting $1"
bash pdfExtractor.sh "$1"
echo "getting json files"
filename=$(basename "$1" .pdf)
filename=${filename//[^a-zA-Z0-9]/_} 
ruby jsonify.rb "$1.txt" > "$filename.json"
rm "$1.txt"
echo "addresses located in $filename.json"
