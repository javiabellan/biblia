# Hardware

```
Mother board           1*1030€ = 1030€  https://www.pccomponentes.com/asus-pro-ws-wrx80e-sage-se-wifi
CPU 32 cores           1*3500€ = 3500€
6 x GPU 3090           6*2200€ = 13000€
256GB RAM (8 x 32GB)   8*225€  = 1800€
16TB NVMe (8 x 2TB)    8*320€  = 2650€
128TB HHD (8 x 8TB)    8*320€  = 2650€
=======================================
                                 25000€
```

| Componente                        | Precio | Inic. | Mej 1 | Mej 2 | Mej 3 | Mej 4 | Mej 5 | Mej 6 |
|-----------------------------------|--------|-------|-------|-------|-------|-------|-------|-------|
| Mother board (ASUS PRO WS WRX80E) | 1030€  |   x1  |       |       |       |       |       |       |
| CPU (AMD thradripper 5975WX)      | 3500€  |   x1  |       |       |       |       |       |       |
| GPU (Nvidia RTX 3090)             | 2200€  |   x1  |   x1  |   x1  |   x1  |   x1  |   x1  |   x1  |
| 256GB RAM (8 x 32GB)              | 1800€  |       |       |       |       |       |       |       |
| Almacenamineto SSD M2             |        |       |       |       |       |       |       |       |
| Almacenamineto SSD SATA           |        |       |       |       |       |       |       |       |
| Almacenamineto HDD                |        |       |       |       |       |       |       |       |
| Fuente                            |        |       |       |       |       |       |       |       |
|                                   |        |       |       |       |       |       |       |       |
| Total                             |        | 8530€ |       |       |       |       |       |       |


### Motherboard

- 128 PCIe 4.0 lines
  - Opcion 1
    - 7 GPUS
    - 4 nvmes M.2 (con capacidad raid 0)
  - Opcion 8
    - 6 GPUS
    - 8 nvmes M.2 (con capacidad raid 0)
- 8 ranuras de ram (con ECC)
- CPU: Threadripper Pro (gama 3000 o 5000)
- 8 sata ports

https://www.youtube.com/watch?v=m5xd2ZizMOA


MSI WS WRX80




### CPU AMD

|                         |       |                     | PISTAS  |       |
|                         | CORES | RAM MEMORY          | PCIe4.0 | PRICE | SOCKET
|-------------------------|-------|---------------------|---------|-------|-------
| Ryzen 9 5900X           | 12    | 128GB (2ch)         |   20    |  500€ | 
| Ryzen 9 5950X           | 16    | 128GB (2ch)         |   20    |  670€ |
|                         |       |                     |         |       | 
| Threadripper 3960X      | 24    | 512GB (4ch) 95 GB/s |   64    | 1700€ | sTRX4
| Threadripper 3970X      | 32    | 512GB (4ch) 95 GB/s |   64    |       | sTRX4
| Threadripper 3990X      | 64    | 512GB (4ch) 95 GB/s |   64    |       | sTRX4
|                         |       |                     |         |       | 
|      Marzo 2021         |       |                     |         |       |
| Threadripper Pro 3945WX | 12    | 2TB (8ch) 205 GB/s  |     128 |       | WRX80
| Threadripper Pro 3955WX | 16    | 2TB (8ch) 205 GB/s  |     128 |       |
| Threadripper Pro 3965WX | 24    | 2TB (8ch) 205 GB/s  |     128 |       |
| Threadripper Pro 3975WX | 32    | 2TB (8ch) 205 GB/s  |     128 | 3500€ |  ESTE ES EL DE ANDRES
| Threadripper Pro 3995WX | 64    | 2TB (8ch) 205 GB/s  |     128 | 6000..8000€ |
|                         |       |       |         |       | 
|      Marzo 2022         |       |       |         |       |
| Threadripper Pro 5945WX | 12    | 8                                     sWRX8
| Threadripper Pro 5955WX | 16    | 8
| Threadripper Pro 5965WX | 24    | 8
| Threadripper Pro 5975WX | 32    | 8
| Threadripper Pro 5995WX | 64    | 8
|                         |
| Gama de servidores      |       |            
| EPYC 7001
| EPYC 7002
| EPYC 7003

https://gadgetversus.com/processor/amd-ryzen-threadripper-pro-3955wx-specs/


MAL: pero no lo recomineda pq tine contencion de memoria pq tiene 4 canales
Andres recomienda la gama Threadripper antes que la Epyc
pq caundo usas porcesoso de 1 solo hilo con 1 solo nueclo va mas rápido.



la serie pro de los thradriper (acaba en 5) tiene soporte para 8 canales en memoria



### PCIe

| PCIe |   Bits    |  x1        |  x4 (Nvme) |  x8         |   x16 (GPU) |
| -----|-----------|------------|------------|-------------|-------------|
| 1.0  |   8b/10b  |   250 MB/s | 1 GB/s     |      2 GB/s |      4 GB/s |
| 2.0  |   8b/10b  |   500 MB/s | 2 GB/s     |      4 GB/s |      8 GB/s |
| 3.0  | 128b/130b | 984.6 MB/s | 3.938 GB/s |  7.877 GB/s | 15.754 GB/s |
| 4.0  | 128b/130b | 1.969 GB/s | 7.877 GB/s | 15.754 GB/s | 31.508 GB/s |


### GPU

                CUDA   Tensor                              FP64
GPU   Realese   cores   cores   Memory       Watts  Price  tFPLOS
-------------------------------------------------------
A2    Nov 2021   1280            24GB GDDR6    50
A10   Apr 2021   9216            24GB GDDR6   150

3090 (24GB)
A6000

A16   Apr 2021  10240          4x16GB GDDR6   250
A30   Apr 2021   3584            24GB HBM2    165   5.000€ (5,2) 10,3 
A40   Oct 2020  10752    336     48GB GDDR6   300   5.000€
A100  May 2020   6912            40GB HBM2    250  10.000€
A100  May 2020   6912            40GB HBM2BULK250  10.000€
A100  May 2020   6912            80GB HBM2    250  20.000€



### Discos duros

                          lectura seq     escritura seq
-------------------------------------------------------
HDD                       80..150 MB/s     80..150 MB/s 
SSD SATA                 500..550 MB/s    450..500 MB/s
SSD M.2 NVMe PCIe 3.0   3000.3500 MB/s   3000.3500 MB/s
SSD M.2 NVMe PCIe 4.0   5000.7000 MB/s   5000.7000 MB/s

> ojo! no todos los SSD M.2 del mercado son NVMe, también hay unidades **M.2 SATA**.
>
> Loss M.2 NVMe PCIe tienen un problema denominado Thermal Throttling: el rendimiento cae drásticamente cuando se da una temperatura muy elevada. Por lo tanto hay que refrigerarlos bien.



        | Que hace                                                                   | Cuando usar
--------|-----------------------------------------------------------------------------------------------
RAID 0  | Todos los dicos actuan como 1 solo (se lee y escribe en paralelo en todos) | Cuando se busca velocidad
RAID 1  | La inforacion se duplica | Cuando se busca fualt tolerance
RAID 5  | caca
RAID 6  | caca
RAID 10 | Cuando se busca fualt tolerance con velocidad


RAID 0: lass velocidades de lectura y escritura. Normalmente es la suma de las velocidades de las unidades menos un 10-15%. 


- Maxiama prestaciones (velocidad de escritura y lectura):
  - 1 SSD NVME M2 
  - Varios SSD NVME M2 en RAID 0
- Maxima seguridad a posibles fallos (fault tolerance)
  - RAID 1 or RAID 5

(LVM) Logical Volume Management


### RAM

- ECC RAM: Good for servers