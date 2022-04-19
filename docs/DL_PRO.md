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
> - https://neptune.ai/blog/image-segmentation-tips-and-tricks-from-kaggle-competitions







## AVOID UDA OUT OF MEMORY

If you get a OOM error on the first batch, try...

- Smaller batch size
- Smaller input size (image resolution)
- Half precision (Float16 instead of default Float32)
- Gradient Checkpointing


If you get a OOM error in the middle of training, try...

```python
output = model(input)
loss   = loss_fn(output, target)
del output
gc.collect()
```

### Gradient Checkpointing


Gradient checkpointing reduces the model's memory cost by 60% (at the cost of 25% greater training time).

- https://spell.ml/blog/gradient-checkpointing-pytorch-YGypLBAAACEAefHs#:~:text=In%20a%20nutshell%2C%20gradient%20checkpointing,these%20values%20ahead%20of%20time
- https://github.com/prigoyal/pytorch_memonger/blob/master/tutorial/Checkpointing_for_PyTorch_models.ipynb

