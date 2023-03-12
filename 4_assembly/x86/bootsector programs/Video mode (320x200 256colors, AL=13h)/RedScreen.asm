
; nasm RedScreen.asm
; qemu-system-i386 -fda RedScreen

use16
org 0x7C00        ; Bootsector needs to start at address 7C00 of RAM

;;;;;;;;;;;;;;;;;;;;;;;;

; SET VIDEO MODE
;   
mov ax, 0x0013  ; MODE AL=13: 320x200 256 colors
int 0x10        ; Call Bios Interruption
mov ax, 0xA000  ; Video mem starts at 0xA00000 (frame buffer)
mov es, ax      ; Extra Segment = 0xAXXXX


; PAINT SCREEN WITH RED
; 
mov al, 04h     ; RED in 256 colors palette
mov cx, 320*200 ; Counter for all pixels
xor di, di      ; Destination Index = 0
rep stosb       ; [ES:DI] = AL; DI++  (rep CX numeber of times)


cli
hlt


times 510-($-$$) db 0   ; Bootsector padding
dw 0xAA55               ; Final 2 bytes shold be AA55