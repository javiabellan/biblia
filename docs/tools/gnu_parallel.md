# GNU Parallel

https://www.baeldung.com/linux/processing-commands-in-parallel


cat photos.txt | sed 's/,/  /' > photosTAB.txt

####### Option 1 (sequential with for loop)
cat ../photosTAB.txt | while read id url; do wget -O "$id" "$url"; done

####### Option 2 (sequential with for loop)
wget --input-file=<(tail ../photosTAB.txt | cut -d "," -f 2)

####### Option 3 (parallel with xargs)
echo $URL_LIST | xargs -n 1 -P 8 wget -q

####### Option 4 (parallel with gnu parallel)
cat ../photosTAB.txt | parallel --jobs 100 --colsep '\t' wget -O {1} {2}

