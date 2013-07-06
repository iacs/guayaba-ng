#!/bin/bash

for FILE in *.png *.jpg
do 
    convert $FILE -resize 400x "${FILE%%.*}"-th.jpg
done