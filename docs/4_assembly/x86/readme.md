# Diagram

```
                       CPU x86 32bits                                          RAM (4GB)                                   I/O Devices
|------------------------------------------------------------|    0x0000|-------------------------|-------       0x00|-------------------|
|                                                            |          | Interrupt Vector Table  |                  |                   |
|     32bits General Purpose Registers     16bits Status     |    0x0400|.........................|                  |                   |
|  |----------------|--------|--------|  |----------------|  |          | BIOS Data Area 256 Bytes|                  |                   |
|  |"accumulator" [EAX] AH  (AX) AL   |  |               C|  |    0x0500|.........................|                  |                   |
|  |----------------|--------|--------|  |----------------|  |          |                         |              0x40| Time Counter chip | (used for random)
|  |   "base"     [EBX] BH  (BX) BL   |                      |    0x7C00|.........................|  BASE            |                   | 
|  |----------------|--------|--------|    16bits Segments   |          | Boot Sector (512 Bytes) |  RAM             |                   |
|  |   "counter"  [ECX] CH  (CX) CL   |  |----------------|  |    0x7E00|.........................| MEMORY           |-------------------|
|  |----------------|--------|--------|  | [CS] Code Seg  |  |          |                         | 640 KB
|  |   "data"     [EDX] DH  (DX) DL   |  |----------------|  |          |                         |
|  |----------------|--------|--------|  | [DS] Data Seg  |  |          |                         |
|                                        |----------------|  |    0x9FC0|.........................|
|         32bits Index Registers         | [ES] Extra Seg |  |          |                         |
|  |----------------------------------|  |----------------|  |          | Extended BIOS Data Area |
|  |       [ESI] Source Index         |  | [FS] More extra|  |          |                         |
|  |----------------------------------|  |----------------|  |   0xA0000|-------------------------|-------
|  |       [EDI] Destination Index    |  | [GS] More extra|  |          | VGA Graphic mode (64KB) |
|  |----------------------------------|  |----------------|  |   0xB0000|  .....................  |   VIDEO
|  |       [ESP] Stack Pointer        |  | [SS] Stack Seg |  |          |  B&W text mode (32KB)   |  MEMORY
|  |----------------------------------|  |----------------|  |   0xB8000|  .....................  |   128KB
|  |       [EBP] Base Pointer         |                      |          |  Color text mode (32KB) |
|  |----------------------------------|                      |   0xC0000|-------------------------|-------
|                                                            |          |                         |
|  |----------------------------------|                      |          |                         |
|  |       [EIP] Instruction Pointer  | aka Program Counter  |          |                         |
|  |----------------------------------|                      |    0xFFFF|-------------------------|
|                                                            |
|------------------------------------------------------------| 

32bits address bus for up to 4GB of flat addresable RAM.
```


# Types

### Define byte `db`

```
my_number: db 10010001b        ; Saves byte in binary format
my_number: db 145              ; Saves byte in decimal format
my_number: db 0xAF, AFh        ; Saves byte in Hexadecinal format
my_char:   db "a"              ; Saves the ASCII byte represtantion of a char
my_string: db ’Hello world’, 0 ; Saves evert character inside a byte. Last char sholulb be te null char (0)
```

> `db 01001010b, 74, 4Ah, 0x4A, 4ah, 0x4a, "J", 'J'` Define same byte in different ways.
> Machine code: `4A` `4A` `4A` `4A` `4A` `4A` `4A` `4A`


### Define word `dw`
```
my_number: dw  AF3Bh  
```

### Conditional jumps (after compare)

```
cmp x, y    ; Do the comparison (x and y are registers or values)

je address  ; jump if equal                 (x == y)
jne address ; jump if not equal             (x != y)

; Compare signed numbers
jl address  ; jump if less than             (x < y)
jle address ; jump if less than or equal    (x <= y)
jg address  ; jump if greater than          (x > y)
jge address ; jump if greater than or equal (x >= y)

; Compare unsigned numbers
JB adress   ; Jump if Below                 (x < y)
JBE adress  ; Jump if below or equal        (x <= y)
JA adress   ; Jump if Above                 (x > y)
JAE adress  ; Jump if above or equal        (x >= y)
```

http://unixwiz.net/techtips/x86-jumps.html



### Functions

```
mov al , "H"       ; Pass parameters to function (al="H")
call some_function ; Call function

some_function:
    pusha       ; Push all register values to the stack (OPTIONAL FOR SAFETY)
    ; Do the code
    ; You can safely destroy registers here
    popa        ; Restore original register values (OPTIONAL FOR SAFETY)
    ret         ; Jump back after the function call
```



# Modes

|                           | Real Mode     | Protected Mode | Long Mode |
|---------------------------|---------------|----------------|-----------|
| Bits for data (word size) | 16 bits       |     32 bits    | 64 bits   |
| Bits for memory           | 20 (Max 1 MB) |     32 bits    |           |
| Memory protection         | no            |       yes      |           |
| Virtual memory (Paging)   | no            |       yes      |           |
| 32bit offsets             | no            |       yes      |           |
| More than 1MB             | no            |       yes      |           |
| Notes                     | Bootsector default |


- Real mode: Real memory addresses.
- Protected mode:  virtual memory.




# Instruction set

Additional instruction sets available, including the floating point, MMX, and SSE operations.







> Bootsector
> Note that at booting time, the firts program to execute is the bootsector (512 bit). This code is in **16bit in Real Mode** that means that we only can access x86-16bits registers and the maximun memory is 1Mb.
> http://kernelx.weebly.com/writing-a-bootsector.html
https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf ---> voy por 3.3.2



x86 assembly language has two main syntaxs: Intel and AT&T.

|            | Intel syntax                     | AT&T syntax           |
|------------|----------------------------------|-----------------------|
| OS         | Windows and DOS                  | Linux, Unix and MacOS |
| Assemblers | NASM, FASM, MASM, TASM, and YASM | GNU Assembler (GAS)   | 





# Memory sections
                                                                       Can write during execution
|-----------------|--------------------------------------------------|---------
| `section .text` | Memory space for the **code of the program**     | no
| `section .data` | Memory space for the **initialized variables**   | yes
| `section .bss`  | Extra future memory space that the program needs | yes







# Hello world


```asm
section .data

   my_message db "hola",0x0A,0    # Define bytes "hola\n"  0x0A=\n  0=End of String in C

section .text
   

