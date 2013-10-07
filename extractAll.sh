#!/bin/bash
find * -type f|grep [0-9]\.pdf$ |while read file
do
  bash extractAndPrint.sh "$file"
  echo $file
done
