# x86 booting

At booting time, the boot software reads the **first 512 bytes of some device** (floppy disks, CD-ROM drive, or hard drive) and place it at address 0x7C00

1. The BIOS software is loaded from firmware into memory.
   - Interrupt service routines (ISRs)
2. It performs various operations:
   - RAM detection
   - and other hardware detection/initializations
3. Attempts to **find a device** which will load the os. (floppy disks, CD-ROM drive, and then hard drive).
4. Execute the bootsector software (16bits Real mode)
   - **Copy the first 512 bytes of some device into address 0x7C00 of RAM**.
   - This 512 btytes are called **Boot sector** or **Master Boot Record**.
   - The last word (2 bytes) of the boot sector must be **0xAA55**.
5. Change to 32 bits protected mode
   1. The bootsector shold have the **Global Descriptor Table (GDT)**, which defines memory segments and their protected-mode
attributes.
   2. Set a single bit in a special CPU control register to make the actual switch.
   3. Now we can access longer registers (eax, ebx, ...). And adress up to 4GB of RAM. **But we can no longer use
BIOS calls :(**



http://kernelx.weebly.com/writing-a-bootsector.html



# Video memory

The video memory of the VGA is mapped to the PC's memory via a window in the range between segments 0xA0000 and 0xBFFFF in the PC's real mode address space (A000:0000 and B000:FFFF ). Typically, these starting segments are:

0xA0000 for EGA/VGA graphics modes (64 KB)
0xB0000 for monochrome text mode (32 KB)
0xB8000 for color text mode and CGA-compatible graphics modes (32 KB)


# Interruptions

a mechanism that allow the CPU temporarily to halt what it is doing and
run some other, higher-priority instructions before returning to the original task.

The BIOS loads into memory some pieces of code to handle this interruptions: **Interrupt service routines (ISRs)**

- Interrupt 0x10 causes the screen-related ISR to be invoked
- Interrupt 0x13, the disk-related I/O



### Set video mode (`AH = 0x00` and the [10h interruption](https://es.wikipedia.org/wiki/Int_10h))



| AL   | Resolution |    Colors    | Video memory                 | Free memory    |
|------|------------|--------------|------------------------------|----------------|
| 0x12 |   640x480  |  16 (4 bits) | 153.600 bytes (0xA000:AF9FF) | (AFA00:AFFFF)  |
| 0x13 |   320x200  | 256 (8 bits) |  64.000 bytes                |                |





```
mov AH 0x00      ; necesary
mov AL XXXX
; TEXT MODES --> Video memory start at 0xb8000
;
;   mov AL 00h   40x25 characters. 16 greys
;   mov AL 01h   40x25 characters. 16 colors
;   mov AL 02h   80x25 characters. 16 greys
;   mov AL 03h   80x25 characters. 16 colors  
;
; VGA (GRAPHIC) MODES --> Video memory start at 0xA000
;
;   mov AL 11h           2 colors
;   mov AL 12h   640x480 16 colors    153.600 bytes
;   mov AL 13h   320x200 256 colors    64.000 bytes     (1 byte)

int 0x10.     ; Call the the 10h interruption

```
