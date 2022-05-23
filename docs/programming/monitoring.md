# Monitoring

## CPU & RAM

### top

### htop





## GPU


### nvidia-smi

`watch -n 0.1 nvidia-smi`: Watch every 0.1 seconds the output of nvidia-smi

![](../img/monitoring/gpu/1-nvidiasmi.png)


`nvidia-smi --query-gpu=timestamp,name,pci.bus_id,temperature.gpu,utilization.gpu,utilization.memory --format=csv -l 1`


![](../img/monitoring/gpu/2-nvidiasmi2.png)


Others:
- `nvidia-smi -q -d TEMPERATURE,PERFORMANCE`: To see the slowdown/shutdown behavieour based on their temperature. If you frequently see HW Slowdown is activated, you probably need to improve the cooling of your machine. 
- `nvidia-smi topo -m`: shows the “GPU topology“, which describes how GPUs are connected. The topology is important to understand if data transfers between GPUs are being made via direct memory access (DMA) or through host devices.



### gpustat

a Python libary (`pip install --user gpustat`) to in a more concise, prettier, and simpler way (one line per GPU)

![](../img/monitoring/gpu/3-gpustat.png)



### nvtop

![](../img/monitoring/gpu/4-nvtop.png)



### nvitop

![](../img/monitoring/gpu/5-nvtop.png)

![](../img/monitoring/gpu/6-nvtop2.png)



### jupyterlab-nvdashboard

- `pip install --user jupyterlab_nvdashboard`

![](../img/monitoring/gpu/7-jupyterlab-nvdashboard.png)


### Weights & Biases

![](../img/monitoring/gpu/8-wandb.png)



### Grafana

![](../img/monitoring/gpu/9-grafana.png)





### Reference

https://lambdalabs.com/blog/keeping-an-eye-on-your-gpus-2/