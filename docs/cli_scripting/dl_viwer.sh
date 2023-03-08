#!/bin/bash

# Example of usage:
#
# ./dl_viewr.sh 4_IMGs 16

images_dir=$1; echo "Image dir: $images_dir"
batch_size=$2; echo "Batch size: $batch_size"


declare -i iter=1
dataset=$(find $images_dir -type f | sort -R | xargs -n $batch_size)
echo "Num iters: $(echo "$dataset" | wc -l)"

while true
do
	echo ""
	read -p "  Select an iteration: " iter
	montage $(echo "$dataset" | sed -n "$iter"p) - | imgcat
done


#time djpeg man.jpg | convert - -flop - | convert - -resize 100x100 - > /dev/null
#djpeg man.jpg                            0,00s user 0,00s system  51% cpu 0,008 total
#convert - -flop -                        0,04s user 0,01s system 209% cpu 0,023 total
#convert - -resize 100x100 - > /dev/null  0,02s user 0,01s system  63% cpu 0,048 total



# EXAMPLE OF DATALOADING PIPELINE
#                        libjpeg-turbo
cat imgs.tsv | sort -R | djpeg filename | convert - resize 224x224 - | conver - flop -