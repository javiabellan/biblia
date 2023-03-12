# ARM

### History

- **ARM v7**: Released in 2007.
- **ARM v8**: Released in 2013. Introduced the 64 bits.
- **ARM v9**: Annouonced in 2021. Focus on secure execution and compartmentalisation.

### Registers

- ARM 32 bits: r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, sp, lr, pc
- ARM 64 bits: X0 to X30, SP, PC


### Instructions

Every instruction takes 4 bytes in machine code. (2 bytes in thumb mode).


- Arithmetic (64 bits integer): `ADD`, `ADC`, `SUB`, `SBC`, `RSB`, `RSC`
  - `ADD X4, X3, X2` X4 = X3 + X2
- Logical:  `AND`, `ORR`, `EOR`, `BIC`
- Comparison:  `CMP`, `CMN`, `TST`, `TEQ`
- Data movement (64 bits addresing):  `MOV`, `MVN`
  - Immediate to register: `MOV X2, #0x6E3A` (limited to 16 bits) (1 intruction)
    - mov r0, #5     ; r0 = 5
    - mov r1, r0     ; r1 = r0 
  - **Load**
    - Load Immediate: `LDR X2, #0x1234ABCD1234ABCD` (limited to 64 bits) (several intructions)
    - Load Adress: `LDR X2, =some_label` (limited to 64 bits) (several intructions)
    - LoaD from memory: `LDR X2, [X1]`
    - LoaD from memory with offset: `LDR X2, [X1, #8]`
  - **Store**
    - STore Regiter into memory: `STR X2, [X1]`
- Branching (Jumps)
  - `B to_label`: Branch (unconditinal jump)
  - `BEQ to_label`: Branch if EQual (if zero flag==1)
- Others
  - `NOP`: Do nothing


More info: [ARM Cortex-A Series Programmer’s Guide for ARMv8-A](https://developer.arm.com/documentation/den0024/a/)


### SIMD Insturctions (ARM NEON)





### Tools

> ```
> sudo pacman -S aarch64-linux-gnu-gcc      # The GNU Compiler Collection - cross compiler for ARM64 target
> sudo pacman -S aarch64-linux-gnu-binutils # A set of programs to assemble and manipulate binary and object files for the ARM64 target
> sudo pacman -S qemu                       # A generic and open source machine emulator and virtualizer
> sudo pacman -S qemu-arch-extra            # QEMU for foreign architectures
> ```

- `aarch64-linux-gnu-as`: The assembler
- `aarch64-linux-gnu-gcc`: The C compiler
- `aarch64-linux-gnu-ld`: The linker
- `aarch64-linux-gnu-objcopy`: To convert ELF executable into IMG format
- `aarch64-linux-gnu-objdump`: Utility to disassemble executables (for debugging)
- `aarch64-linux-gnu-readelf`: An useful utility to dump sections and segments in executables (for debugging)


### References

- BroadCom
  - [VideoCore IV Architecture Guide](https://docs.broadcom.com/doc/12358545)
  - https://github.com/nineties/py-videocore
  - https://github.com/Idein/py-videocore6
- ARM
  - [ARM Cortex-A Series Programmer’s Guide for ARMv8-A](https://developer.arm.com/documentation/den0024/a/)
  - [Arm Cortex-A53 MPCore Processor Technical Reference Manual](https://developer.arm.com/documentation/ddi0500/latest/)
- QEMU
  - [QEMU for Raspberry](https://qemu-project.gitlab.io/qemu/system/arm/raspi.html)
- Raspberry Pi BareMetal
  - https://github.com/bztsrc/raspi3-tutorial
  - https://www.youtube.com/playlist?list=PLVxiWMqQvhg9FCteL7I0aohj1_YiUx1x8
  - https://github.com/raspberrypi/documentation/tree/master/hardware/raspberrypi
