# Deep learning PRO


## 1. Read data from disk fast

- ERROR: Slow reading
  - PIL
  - OpenCV
- GOOD: Fast file reading
  - turbojpeg: For faster
- VERY GOOD: Preparsear los ficheros y cargar diercamente el tensor
  - Numpy Memmap or Torch storage
  - [FFCV](https://ffcv.io)

> Note: Buy NVMe drives and put the dataset there


## 2. Fast DataAug & transfoms

- ERROR
  - Torchvision tranforms (based on PIL)
  - Albumatations (based on OpenCV)
- GOOD
  - Fastai agmentations (on GPU)
  - Kornia: agmentations (on GPU)

## 3. Model optimizaation

- Quantization aware training
- Float16

## 4. Training loop optimization
- Composer


## 5. Distributed treainng (Several GPUs)

- [Pytorch DDP](https://pytorch.org/tutorials/intermediate/ddp_tutorial.html): Data parallelisom
- [DeepSpeed](https://www.deepspeed.ai): : Model parallelisom
- [FSDP](https://fairscale.readthedocs.io/en/stable/api/nn/fsdp.html)


> ## References
> - https://pytorch.org/blog/efficient-pytorch-io-library-for-large-datasets-many-files-many-gpus/
> - https://towardsdatascience.com/setting-a-strong-deep-learning-baseline-in-minutes-with-pytorch-c0dfe41f7d7
> - https://towardsdatascience.com/gpus-are-fast-datasets-are-your-bottleneck-e5ac9bf2ad27
> - https://towardsdatascience.com/pytorch-lightning-vs-deepspeed-vs-fsdp-vs-ffcv-vs-e0d6b2a95719



