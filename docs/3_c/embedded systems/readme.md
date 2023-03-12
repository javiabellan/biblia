<h1 align="center">Embedded systems</h1>

### Micocontrollers (MCUs)

|  | CPU | Bits | Cores | Clock<br><sup>(MHz) | Memory<br><sup>(SRAM) | Storage<br><sup>(Flash) | TF | Others | Price |
|:-----------------------------:|:--------------:|:----:|:-----:|:--------:|:------:|:-----:|---:|:--------:|:-----:|
| **Arduino Uno (Rev3)**        | AVR            |   8  |    1  |  16..20  |    2KB |  32KB | ❌ |          |  20€  |
| **Raspberry Pi Pico**         | ARM Cortex-M0+ |  32  |    2  | 125..133 |  264KB |   2MB | ✅ |          |   4€  |
| **Arduino Nano 33 BLE**       | ARM Cortex-M4  |  32  |    1  |  64..xxx |  256KB |   1MB | ✅ | 🔷       |  17€  |
| **Arduino Nano 33 BLE Sense** | ARM Cortex-M4  |  32  |    1  |  64..xxx |  256KB |   1MB | ✅ | 🔷🎤🧭   |  32€  |
| **Adafruit EdgeBadge**        | ARM Cortex-M4  |  32  |    1  |    120   |  192KB | 2.5MB | ✅ |          |  31€  |
| **SparkFun Edge**             | ARM Cortex-M4  |  32  |    1  |  48..96  |  384KB |   1MB | ✅ | 🔷🎤🧭   |  16€  |
| **Espressif ESP8266**         | Xtensa LX106   |  32  |    1  |  80..160 |   64KB |   4MB | ❌ | 🌐🔷     |   2€  |
| **Espressif ESP32**           | Xtensa LX6     |  32  |    2  | 160..240 | 520KiB |   4MB | ✅ | 🌐🔷     |   3€  |
| **Espressif ESP-EYE**         | Xtensa LX6     |  32  |    2  | 160..240 | 520KiB |   4MB | ✅ | 🌐🔷🎤📷 |  18€  |

> - Other microcontrollers
>   - STM32
>   - Texas Instruments MSP430
>   - TinyPico
> - Legend
>   - 🌐: WiFi
>   - 🔷: Bluetooth
>   - 📷: Camera
>   - 🎤: Microphone
>   - 🧭: Accelerometer with magnetometer
> - Common architectures: ARM Cortex-M, RISC-V, Hexagon, Xtensa
> - Jacob Sorber works a lot with Texas Instruments MSP430
> - https://wokwi.com/
> - https://vivonomicon.com/2019/03/30/getting-started-with-bare-metal-esp32-programming/


### Single Board Computers (SBCs)


Rememeber that:
```
     System on Module (SoM)
 +      Carrier Board (CB) 
---------------------------
Single Board Computer (SBC)
```
  
|                           | CPU                | Bits | Cores | Clock<br><sup>(GHz) | Memory<br><sup>(RAM)   | GPU    | Price |
|--------------------------:|:------------------:|:----:|:-----:|:----:|:--------:|:---------------------:|:------|
| **Raspberry Pi 1**        | ARM11 1176JZF-S    |  32  |   1   | 0.7  |0.25,0.5GB| VideoCore IV          |       |
| **Raspberry Pi 2**        | ARMv7-A Cortex-A7  |  32  |   4   | 0.9  |   1 GB   | VideoCore IV          |       |
| **Raspberry Pi 3**        | ARMv8-A Cortex-A53 |  64  |   4   | 1.4  |   1 GB   | VideoCore IV          |       |
| **Raspberry Pi 4**        | ARMv8-A Cortex-A72 |  64  |   4   | 1.5  | 1,2,4,8GB| VideoCore VI          |40,80€ |
| **Jetson Nano**           | ARMv8-A Cortex-A57 |  64  |   4   | 1.43 |   2 GB   | 128CUDA cores Maxwell |   77€ |
| **Jetson Nano B01**       | ARMv8-A Cortex-A57 |  64  |   4   | 1.43 |   4 GB   | 128CUDA cores Maxwell |  156€ |
| **Coral Dev board**       | ARMv8-A Cortex-A53 |  64  |   4   | 1.5  |   1 GB   | Vivante GC7000Lite    |  136€ |
| **Coral Dev board mini**  | ARMv8-A Cortex-A35 |  64  |   4   | 1.5  |   2 GB   | IMG PowerVR GE8300    |  110€ |
| **Coral Dev board micro** |                    |      |       |      |          |                       |       |


|                       | CPU cores               | GPU cores              | TPU cores    | NVDLA  | Power           | Connector        | Price     |
|-----------------------|:-----------------------:|------------------------|--------------|--------|-----------------|------------------|-----------|
| **Jetson Nano**       | 4 ARM A57 @ 1.43GHz     | 128 Maxwell @ 921 MHz  | -            | -      | 5W / 10W        |                  | 77€, 156€ |
| **Jetson TX1**        | 4 ARM A57 @ 1.73GHz     | 256 Maxwell @ 998MHz   | -            | -      | 10 W            |                  | $300      |
| **Jetson TX2**        | 4 ARM A57 @ 2GHz        | 256 Pascal  @ 1.3 GHz  | -            | -      | 7.5W / 15W      |                  | 500€      |
| **Jetson Xavier NX**  | 6 ARM Carmel            | 384 Volta              | 48 Volta     | 2      | 10W / 15W / 20W | 260 pins SO-DIMM | 430€      |
| **Jetson AGX Xavier** | 8 ARM Carmel @ 2.26 GHz | 512 Volta              | 64 Volta     | 2      | 10W / 15W / 30W | 699 pins         | 750€      |
| **Jetson Orin NX**    | 8 ARM A78AE             | 1024 Ampere            | 32 Ampere    | 2 v2.0 | 10W / 15W / 25W | 260 pins SO-DIMM | no yet    |
| **Jetson AGX Orin**   | 12 ARM A78AE            | 2048 Ampere            | 64 Ampere    | 2 v2.0 | 15W / 30W / 50W | 699 pins         | no yet    |


> ### NVDLA
>
> The NVDLA (Nvidia Deep Learning Accelerator) is an alternative to the GPU,
> and it can be used with minimal change in software.
> It is not as fast as the GPU but is extremely power efficient.
> So, if you need your application to run at all times and power consumption is an issue, you should try to use the DLAs.








### Programming

|                 | IDE         | Compiler               | Emulator                         | Uploader   |
|-----------------|-------------|------------------------|----------------------------------|------------|
| AVR (Arduino)   | Arduino IDE | `avr-gcc`              |                                  | `avr-dude` |
| MSP430          | Energia.nu  | `msp430-gcc`           |                                  | `mspdebug` |
| ESP32           | ESP IDF     | `esp32-gcc`            |                                  |            |
| ESP8266         | ESP IDF     | `esp8266-gcc`          |                                  |            |
| Raspberry Pi 2B |             |                        | `qemu-system-aarch64 -M raspi2b` |            |
| Raspberry Pi 3B |             |                        | `qemu-system-aarch64 -M raspi3b` |            |
| ARM64           |             |`aarch64-linux-gnu-gcc` |                                  |            |

> ESP IDF: Espressif IoT Development Framework

- [Getting Started with Programming in AVR C | Attiny45 Blink LED Tutorial](https://www.youtube.com/watch?v=tJLxgixq9VQ)



## Main issues in Embedded systems programming

### Issue number 1: Memory limit


### Issue number 2: Power consumption

1mW -> 1 año con una batería de botón

Red neuronal -> 1mW
Sensor de camara -> 10mW




## References

- Hardware
  - https://qengineering.eu/deep-learning-with-raspberry-pi-and-alternatives.html
  - https://qengineering.eu/computer-vision-with-raspberry-pi-and-alternatives.html
  - https://www.fastcompression.com/blog/jetson-benchmark-comparison.htm
- Jacob Sorber [Embedded Systems playlist](https://www.youtube.com/playlist?list=PL9IEJIKnBJjEcPAz6fss-Hx0TLytCOMVC)
- Links Juanjo. Cubren RPI, Arduino y ESP32 que son mis placas de desarrollo favoritas.
  - https://projects.raspberrypi.org/en
  - https://docs.platformio.org/en/latest/
  - https://www.arduino.cc/en/Tutorial/HomePage
  - https://arduinojson.org/book/
  - https://magpi.raspberrypi.org/
  - https://www.itead.cc/blog
  - https://www.esploradores.com/
