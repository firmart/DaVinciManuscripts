#!/bin/zsh
mkdir -p codex-atlanticus && cd codex-atlanticus
wget http://codex-atlanticus.it/assets//2000/000{R,V}-{1..1119}.jpg
for i in {1..1119}; do
    mv 000R-$i.jpg $(printf "%04d" $i)R.jpg
    mv 000V-$i.jpg $(printf "%04d" $i)V.jpg 
done
printf '%s\0' *.jpg | parallel --null -t -n 10 convert {} "output-{#}.pdf"
for i in {1..100}; do
    mv output-$i.pdf output-$(printf "%02d" $i).pdf
done
pdftk output-*.pdf cat output codex-atlanticus.pdf
rm output-*.pdf
mkdir -p ../output && mv codex-atlanticus.pdf ../output
