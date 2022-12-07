

### Write
```python
file_imgIdPerFaces  = open(dest_path+'editorial_imgIdPerFaces_uint32', mode='wb')

for path in tqdm(paths_editorial):
    np.array(img_id, dtype="uint32").tofile(file_imgIds)
    np.load(path + "/emb_img.npy").tofile(file_imgEmbs)

os.rename(dest_path+'editorial_imgIds_uint32',        dest_path+f'editorial_imgIds_{num_total_imgs}_uint32')
```

### Read

```python
embs_creat = np.memmap(path+"creativo_imgEmbs_1103426x512_float32",
	                   dtype='float32',
	                   mode='r',
	                   shape=(1103426,512))
```


https://stackoverflow.com/questions/51086704/append-numpy-matrix-to-binary-file-without-numpy-header