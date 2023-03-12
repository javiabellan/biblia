
# 🖥️ Architectures History


|            | Date | Arch  | Bits    | RAM Memory     | Speed   | Transistors |
|------------|------|-------|---------|----------------|---------|-------|
| 8080       | 1974 |       |  8 bits |                | 2 MHz   |  6000 |
| 6502       | 1975 |       |  8 bits |                | 1 MHz   |  3510 |
| Zilog z80  | 1976 |       |  8 bits | 16 bits (64Kb) | 2.5 MHz |  8500 |
| 8086       | 1978 | `X86` | 16 bits | 20 bits (1Mb)  | 5 MHz   |   29K |
| 68000      | 1979 |       | 16 bits |                | 8 MHz   |   68K |
| i286       | 1982 | `X86` | 16 bits |                | 6 MHz   |  134K |
| MIPS       | 1983 |       | 32 bits |                |  2 MHz  |   25K |
| i386       | 1985 | `X86` | 32 bits |                | 16 MHz  |  275K |
| i486       | 1989 |       | 32 bits |                | 25 MHz  | 1180K |
| Pentium    | 1993 |       | 32 bits |                | 60 MHz  |  3.1M |
| Pentium 4E | 2004 | `X86` | 64 bits |              | 2800-3800 |  125M |


https://en.wikipedia.org/wiki/Microprocessor_chronology


# CISC vs RISC

| CISC                                |  RISC                        |
|-------------------------------------|------------------------------|
| Larger more complex instruction set | Small simple instruction set |
| Fewer registers                     | Larger set of registers      |
| Variable lenght instructions        | Fixed lenght instructions    |
| Instructions cant take multiple clock cycles to execute | Each instruction takes 1 clock cycle (except `DIV`) |  
| Can perform arithmetic + memory acces in the same instruction | Memory and arithmetic instructions are separated |


Source: https://www.youtube.com/watch?v=GBRdzaAxHB8

# 🖥️ Architectures (and emulators)

> ```
> sudo pacman -S nasm                       # A 80x86 assembler designed for portability and modularity
> sudo pacman -S fasm                       # Fast and efficient self-assembling x86 assembler for DOS, Windows and Linux
> sudo pacman -S aarch64-linux-gnu-gcc      # The GNU Compiler Collection - cross compiler for ARM64 target
> sudo pacman -S aarch64-linux-gnu-binutils # A set of programs to assemble and manipulate binary and object files for the ARM64 target
>
> sudo pacman -S qemu                  # A generic and open source machine emulator and virtualizer
> sudo pacman -S qemu-arch-extra       # QEMU for foreign architectures
> ```


|             | Family | Instruction Length | Common Machines            | QEMU                                        | Assembler               |
|-------------|--------|--------------------|----------------------------|---------------------------------------------|-------------------------|
| **x86**     | CISC   | 1..15 bytes        | Intel and AMD PCs          | `qemu-system-i386` `qemu-system-x86_64`     | `nasm`                  |
| **ARM**     | RISC   | 2 bytes or 4 bytes | iPhone, Android, Raspberry | `qemu-system-arm` `qemu-system-aarch64`     | `aarch64-linux-gnu-gcc` |
| **RISC-V**  | RISC   | 4 bytes            |                            | `qemu-system-riscv32` `qemu-system-riscv64` |                         |
| **MIPS**    | RISC   | 4 bytes            |                            | `qemu-system-mips`                          |                         |
| **PowerPC** | RISC   | 4 bytes            |                            | `qemu-system-ppc64`                         |                         |
| **AVR**     | RISC   | 1 byte             | Arduino microcontrollers   | `qemu-system-avr`                           |                         |


- [QEMU](https://qemu-project.gitlab.io/qemu/system/targets.html)
- *ARM:
  - Thumb mode: 2 bytes per instruction
  - ARM mode: 4 bytes per instruction


## Online assemblers

- X86
  - https://kobzol.github.io/davis
- ARM
  - [OakSim](http://wunkolo.github.io/OakSim)
  - [cpulator](https://cpulator.01xz.net/?sys=arm)
- RISC-V
  - https://www.cs.cornell.edu/courses/cs3410/2019sp/riscv/interpreter

## SIMD

- SIMD: Fixed vector lenth and element lenh on HARDWARE
  - BAD becaouse they significally increase the instrusion set (from 80 to around 1400 instructions)
  - Used for: When the need was primarily needed for short vectors in multimedia settings (1990s, 2000s)
  - Ref: https://www.sigarch.org/simd-instructions-considered-harmful
- Vector instruction-set: Variable vector lenth and element lenh on HARDWARE
  - Good, used in RISC-V (actually the V in RISC-V stands for both 5 and for Vector)
  - Used for: excellent choice for machine learning applications
  - Vector computers gather objects from main memory and put them into long, sequential vector registers.
  - the assembly code instructions are not tied to specific vector lengths


## Branching (jumps)

Branching is quite bad for a pipelined microprocessor. In pipelining instructions are queued up and the execution of one instruction begins before the execution of an earlier one is done.

Soultion: Conditional Instructions
- x86 Conditional Moves (introduced in i686):

CMP    ax, 42
CMOVE  bx, 33  ; bx ← 33 if ax = 42
CMOVNE bx, 12  ; bx ← 12 if ax ≠ 42



# Assemblers


- **STEP 1: WRITE PROGRAM**: Assemble your program into machine code (`.img`)
  - `as`: the portable GNU assembler.
  - `nasm`: the Netwide Assembler, a portable 80x86 assembler
    - `nasm program.asm -o program.img` 
    - `nasm program.asm -o program.bin -O3 -f bin` 
  - `fasm`
- **STEP 2: RUN PROGRAM**:
  - **OPTION A**: Run your code into an **emulator** (QEMU)
    - `qemu-system-i386 -hda program.img`
    - `qemu-system-i386 -fda program.img` Floppy
    - `qemu -M pc -soundhw pcspk -fda program.bin`
  - **OPTION B**: Run your code **real hardware** (Copy your image into a USB stick)
     - Insert an USB, determine its device (`/dev/sdX`) with `sudo lsblk`or `sudo fdisk -l`
     - Pick the `.img` file and: `sudo dd if=program.img of=/dev/sdX bs=512`
     - insert the USB in a computer
     - during boot, hit some special hardware dependant key, usually F12, Esc
     - choose to boot from the USB

> [Nice Stackoverovleow answer](https://stackoverflow.com/questions/22054578/how-to-run-a-program-without-an-operating-system/32483545#32483545)






# References


### General References
- X86
  - [WikiBook: x86 Assembly](https://en.wikibooks.org/wiki/X86_Assembly)
  - [x86 Bare Metal Examples](https://github.com/cirosantilli/x86-bare-metal-examples)
  - Bootloader
    - https://www.joe-bergeron.com/posts/Writing%20a%20Tiny%20x86%20Bootloader/
    - https://www.alanfoster.me/posts/writing-a-bootloader
    - http://3zanders.co.uk/2017/10/13/writing-a-bootloader 
- ARM
  - [Embedded Systems with ARM](https://www.youtube.com/channel/UCY0sQ9hpSR6yZobt1qOv6DA/videos) (Youtube channel)
- [QIRA](http://qira.me) by George Hotz

### Videogames References
- [Profesor RetroMan](https://www.youtube.com/c/ProfesorRetroMan/videos) (youtube channel)
- [FABIEN SANGLARD'S WEBSITE](https://fabiensanglard.net)
- [List of Boot Sector Games](https://gist.github.com/XlogicX/8204cf17c432cc2b968d138eb639494e)
- [Queso Fuego](https://www.youtube.com/channel/UCeT6NdimLKHXlkQgrbcg6XQ) (youtube channel)
  - [Pong in 386](https://www.youtube.com/watch?v=mYPzJlqQ3XI)
  - [Space invaders in x86](https://www.youtube.com/watch?v=TVvTDjMph1M)
  - [Snake in x86](https://www.youtube.com/watch?v=wQfOYeZDKWk)
- [retro game in a tweet](https://www.quaxio.com/bootloader_retro_game_tweet/)

### Operating Systems References
- [Operating Systems: From 0 to 1](https://github.com/tuhdo/os01) 



###  Nand to Tetris (Coursera free course)
Build a Modern Computer from First Principles (project-centered course)

- Part 1 (**HARDWARE**): **[From NAND to the HACK computer](https://www.coursera.org/learn/build-a-computer)**
  - Week 1: **Elementary Logic Gates** (Nand, Not, And, Or, Xor, Mux, Dmux)
  - Week 2: **Arithmetic Logic Unit** (Halfdder, FullAdder, Add16, Inc16, ALU)
  - Week 3: **Registers and Memory** (Bit Register, RAM8, RAM64, RAM512)
  - Week 4: **Writting low-level programs**
  - Week 5: **Computer Architecture** (Memory, CPU, Computer)
  - Week 6: **Develop an Assembler**
- Part 2 (**SOFTWARE**): **[From the HACK computer to Tetris](https://www.coursera.org/learn/nand2tetris2)**
- Course book: The Elements of Computing Systems: Building a Modern Computer from First Principles





### [Open Security Training](https://opensecuritytraining.info)

- **Beginner**
  - [Introductory Intel x86](https://www.youtube.com/playlist?list=PL038BE01D3BAEFDB0)
  - [Introduction to ARM](https://www.youtube.com/playlist?list=PLUFkSN0XLZ-n91t_AX5zO007Giz1INwPd)
  - [The Life of Binaries](https://www.youtube.com/playlist?list=PLUFkSN0XLZ-n_Na6jwqopTt1Ki57vMIc3)
  - [Malware Dynamic Analysis](https://www.youtube.com/playlist?list=PLUFkSN0XLZ-kqYbGpY4Gt_VATd4ytQg-Z)
  - [Introduction to Trusted Computing](https://www.youtube.com/playlist?list=PLUFkSN0XLZ-kBgdLhorJD6BR66D5kGoUV)
- **Intermediate**
  - [Intermediate Intel x86](https://www.youtube.com/playlist?list=PL8F8D45D6C1FFD177)
  - [Introduction to Software Exploits](https://www.youtube.com/playlist?list=PL96AB65DFCE02EE3E)
  - [Exploits 2: Exploitation in the Windows Environment](https://www.youtube.com/playlist?list=PL9F9E52502327B1CA)
- **Advanced**
  - [Rootkits: What they are, and how to find them](https://www.youtube.com/playlist?list=PLF58FB7BCB20ED11A)
  - [Introduction to Reverse Engineering Software](https://www.youtube.com/playlist?list=PLUFkSN0XLZ-nXcDG89jS9iqKBnNHmz7Qw)
  - Reverse Engineering Malware
  - Advanced x86: Virtualization with Intel VT-x






