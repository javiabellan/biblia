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







```bash
# this code

for i in *gz; do 
  zcat $i > $(basename $i .gz).unpacked
done

# Can be remplazed with
parallel 'zcat {} > {.}.unpacked' ::: *.gz
```

### Real world examples

```bash
### Download files
cat ../photosTAB.txt | parallel --jobs 100 --colsep '\t' wget -O {1} {2}

### Find files that doenst't exists
cut -d, -f5 main.csv | parallel --progress '[ -f {} ] || echo {} >> bad_imgs'

### Check if images are corrupted
cut -d, -f5 main.csv | parallel --progress 'identify {} > /dev/null || echo {} >> bad_imgs'
```




- `{}`  Input line
- `{.}` Input line without extension.
- `{/}` Basename of input line
- `{//}` Dirname of input line
- `{/.}` Basename of input line without extension.
- `{0}` 1st culumn of input_line 
- `{1}` 2nd culumn of input_line 
