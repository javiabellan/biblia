


## Naive implementatation

```
          ┌────────────┐ ┌────────────┐ ┌────────────┐                                 ┌────────────┐
CPU CORE1 │Read image 1│ │Read image 2│ │Read image 3│                                 │Read image 4│ ...
          └────────────┘ └────────────┘ └────────────┘                                 └────────────┘
                                                     ┌───────────┐
CPU 2 GPU                                            │Copy to GPU│
                                                     └───────────┘
                                                                 ┌────────────────────┐
 GPU                                                             │INFER MODEL         │
                                                                 └────────────────────┘
```





## Read images faster


### Hardaware

Try to store your dataset in a fast storage

1. RAM
2. SSDs NVMe RAID
3. SSD NVMe
4. SSDs SATA RAID
5. SSD SATA
6. HDD RAID
7. HDD SATA
8. Other machine in local network (/mnt/media mounting point)
9. Internet


### Option fast: Fast imgedecodin `libjpg-turbo`

- Using [jpeg4py](https://github.com/ajkxyz/jpeg4py): `jpeg.JPEG(img).decode()` instead of `np.array(Image.open(img))`
  - [example of usage](https://www.pankesh.com/posts/2019-05-02-pytorch-augmentation-with-libjpeg-turbo)
- Using `Pillow>=9.0.0` [source](https://pillow.readthedocs.io/en/stable/releasenotes/9.0.0.html#switched-to-libjpeg-turbo-in-macos-and-linux-wheels)

Notese que a partir de la la verion 9 de PIL, viene por defecto 

> Comprobar que PIL usa libjpg-turbo
> ```python
> import PIL.features
> print(PIL.features.check_feature("libjpeg_turbo"))
> ```

### Even faster:

**Precompute tensors and save the on disk**

**For reading just memap, No need to decoding**

- Numpy Memmap
- Torch storage
- [FFCV](https://ffcv.io)



```
          ┌─────────┐ ┌─────────┐ ┌─────────┐                                      ┌─────────┐
CPU CORE1 │Read img1│ │Read img2│ │Read img3│                                      │Read img4│ ...
          └─────────┘ └─────────┘ └─────────┘                                      └─────────┘
                                            ┌───┐┌───────────┐
CPU 2 GPU                                   │Pin││Copy to GPU│
                                            └───┘└───────────┘
                                                              ┌────────────────────┐
 GPU                                                          │INFER MODEL         │
                                                              └────────────────────┘
```


## Optimization: Avoid unnecessary host copies `pin_memory=True`


Host (CPU) data allocations are pageable by default. The GPU cannot access data directly from pageable host memory, so when a data transfer from pageable host memory to device memory is invoked, the CUDA driver must first allocate a temporary page-locked, or “pinned”, host array, copy the host data to the pinned array, and then transfer the data from the pinned array to device memory, as illustrated below.

- https://developer.nvidia.com/blog/how-optimize-data-transfers-cuda-cc/


if `pin_memory=True` is set on the Pytorch's dataloader, it will copy Tensors into device/CUDA pinned memory before returning them.

Also, once you pin a tensor or storage, you can use asynchronous GPU copies. Just pass an additional `non_blocking=True` argument to a `to()` or a `cuda()` call. This can be used to overlap data transfers with computation. (Prefetching on GPU Optimization).


```
          ┌─────────┐ ┌─────────┐ ┌─────────┐                                ┌─────────┐
CPU CORE1 │Read img1│ │Read img2│ │Read img3│                                │Read img4│ ...
          └─────────┘ └─────────┘ └─────────┘                                └─────────┘
                                            ┌───────────┐
CPU 2 GPU                                   │Copy to GPU│
                                            └───────────┘
                                                        ┌────────────────────┐
 GPU                                                    │INFER MODEL         │
                                                        └────────────────────┘
```

## Optimization: Read images in parallel `num_workers`

```
          ┌────────────┐                                 ┌────────────┐
CPU CORE1 │Read image 1│                                 │Read image 4│
          └────────────┘                                 └────────────┘
          ┌────────────┐                                 ┌────────────┐
CPU CORE2 │Read image 2│                                 │Read image 5│
          └────────────┘                                 └────────────┘
          ┌────────────┐                                 ┌────────────┐
CPU CORE3 │Read image 3│                                 │Read image 6│
          └────────────┘                                 └────────────┘
                       ┌───────────┐                                  ┌───────────┐
CPU 2 GPU              │Copy to GPU│                                  │Copy to GPU│
                       └───────────┘                                  └───────────┘
                                   ┌────────────────────┐                         ┌────────────────────┐
GPU                                │INFER MODEL         │                         │INFER MODEL         │
                                   └────────────────────┘                         └────────────────────┘
```


## Optimization: Prefetching on CPU (Queue) `prefetch_factor`


**This is the defual behavior of Pytroch's dataloader**. It does prefetching on the CPU RAM.

the prefetch_factor parameter of PyTorch DataLoader class. The prefetch_factor parameter only controls CPU-side loading of the parallel data loader processes


```
          ┌────────────┬────────────┐
CPU CORE1 │Read image 1│Read image 4│
          └────────────┘────────────┘
          ┌────────────┬────────────┐
CPU CORE2 │Read image 2│Read image 5│
          └────────────┴────────────┘
          ┌────────────┬────────────┐
CPU CORE3 │Read image 3│Read image 6│
          └────────────┴────────────┘
                       ┌──────────┐                    ┌──────────┐
CPU 2 GPU              │123 to GPU│                    │456 to GPU│
                       └──────────┘                    └──────────┘
                                  ┌────────────────────┐          ┌────────────────────┐
GPU                               │INFER 123 into MODEL│          │INFER 456 into MODEL│
                                  └────────────────────┘          └────────────────────┘
```

- [But what are PyTorch DataLoaders really?](https://www.scottcondron.com/jupyter/visualisation/audio/2020/12/02/dataloaders-samplers-collate.html)
- [Building a Multi-Process Data Loader from Scratch](https://teddykoker.com/2020/12/dataloader)
  - The full code for this project is available at github.com/teddykoker/tinyloader
- https://www.jpatrickpark.com/post/loader_sim/





## Optimization: Prefetching on GPU

```
          ┌────────────┬────────────┐
CPU CORE1 │Read image 1│Read image 4│
          └────────────┘────────────┘
          ┌────────────┬────────────┐
CPU CORE2 │Read image 2│Read image 5│
          └────────────┴────────────┘
          ┌────────────┬────────────┐
CPU CORE3 │Read image 3│Read image 6│
          └────────────┴────────────┘
                       ┌──────────┐ ┌──────────┐
CPU 2 GPU              │123 to GPU│ │456 to GPU│
                       └──────────┘ └──────────┘
                                  ┌────────────────────┬────────────────────┐
GPU                               │INFER 123 into MODEL│INFER 456 into MODEL│
                                  └────────────────────┴────────────────────┘
```


- Prefetching Implementation #1: `class data_prefetcher()` in https://github.com/NVIDIA/apex/blob/master/examples/imagenet/main_amp.py#L265
- Prefetching Implementation #2: Sacrife 1 data loader process into a prefetcher process


- https://www.jpatrickpark.com/post/prefetcher/
- https://developer.nvidia.com/blog/how-overlap-data-transfers-cuda-cc/

Achieving overlap between data transfers and other operations requires the use of CUDA streams, so first let’s learn about streams.




## Fast collate (= concat imags into batch) ? 

- https://www.pankesh.com/posts/2019-05-02-pytorch-augmentation-with-libjpeg-turbo/



## Faster Model: TensorRT engine --into--> TorchScript module



- https://pytorch.org/TensorRT/
- https://pytorch.org/TensorRT/_notebooks/lenet-getting-started.html
- https://pytorch.org/TensorRT/py_api/ts.html?highlight=embed#torch_tensorrt.ts.embed_engine_in_new_module


## Summary

For getting fast training/inference 

- Data reading:
  - Use fast data staorage hardware (RAM, NVMe, RAID,...)
  - Use fast data decoding (libjpeg-turbo for images)
  - Even faster is you store precomted tensors and load them with either
    - Numpy.memmap
    - torch.Storage
    - FFIO
- Dataloader
  - Read images in parallel `num_workers`
  - Avoid unnecessary host copies `pin_memory=True`
  - Prefetching on CPU (CPU Queue) `prefetch_factor`
  - Prefetching on GPU (GPU Queue)
- Model
  - TensorRT





## CUDA Programming


Pytorch



```python

my_stream = torch.cuda.Stream()

with torch.cuda.stream(my_stream):
    
    # Send data to GPU (NO BLOCKING)
    data = data.cuda(non_blocking=True) # or data.to("cuda", non_blocking=True)
```


PyCUDA

```python

my_stream = cuda.Stream()

# Send data to GPU (NO BLOCKING)
cuda.memcpy_htod_async(dest=gpu_mem[name], src=cpu_mem[name], stream=my_stream)


cuda.memcpy_dtoh_async(dest=cpu_mem[name], src=gpu_mem[name], stream=my_stream)
```




# Copy betwwnn numpy and pytorch

|                  | Copy by value, Deep copy | Copy by reference, Shallow copy |
|------------------|--------------------------|---------------------------------|
| Numpy to Pytorch | `torch.tensor(my_npArr)` | `torch.from_numpy(my_npArr)`    |
| Pytorch to Numpy | `np.array(my_tensor)`    | `my_tensor.numpy()`             |






|
|---------------------------------------------------------
| my_arr.save(my_file_str)                                              | SLOW
| my_file = open(filepath, mode='wb'); my_arr.tofile(my_file)           | FAST
| my_file = open(filepath, mode='wb'); my_file.write(my_arr.tobytes())  | VERY FAST | Cuidado pq no escribe en disco hasta quellames a file.clos()




https://blog.christianperone.com/2018/03/pytorch-internal-architecture-tour/

