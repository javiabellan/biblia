
; Prints "hello" on screen using the text mode
; 
; Assembly:
;    fasm HelloWorld_3.asm
;
; Execute:
;     qemu-system-i386 -fda HelloWorld_3.bin
;
; More info about text mode:
; https://wiki.osdev.org/Text_UI
;
; ARCHIECTURE: Bootsector x86 (max 512 bytes)
; ASSEMBLER:   fasm




; Hex Color
; 0   Black
; 1   Blue
; 2   Green
; 3   Cyan
; 4   Red
; 5   Magenta
; 6   Brown
; 7   LightGray
; 8   Dark Gray
; 9   Light Blue
; A   Light Green
; B   Light Cyan
; C   Light Red
; D   Light Magenta
; E   Yellow
; F   White



; 48  H
; 65  e
; 6C  l
; 6C  l
; 6F  o


use16

org 0x7C00        ; Needs to start at address 7C00 of RAM



; Set video mode. By using the 10h interruption
;
mov AH, 0x00    ; Set video mode specified on AL
mov AL, 0x03    ; Text mode: 80x25 characters. 16 colors. See more at https://wiki.osdev.org/Text_UI
int 0x10        ; Call the 10h interruption. See more at https://es.wikipedia.org/wiki/Int_10h


; Point to video memory which start at B8000000
; ES:DI = B800:0000
mov ax, 0xB800
mov es, ax     ; Extra Segment = B800


; Print hello world

; H character
mov ax, 0x0E48  ; 0 = Black bck, E = Yellow bck, 48 = H
mov [es:di], ax
inc di
inc di

; e character
mov ax, 0x0B65  ; 0 = Black bck, B = Blue bck, 65 = e
mov [es:di], ax
inc di
inc di

; ll character
mov ax, 0x0C6C  ; 0 = Black bck, C = Red bck, 6C = l
mov [es:di], ax
inc di
inc di
mov [es:di], ax
inc di
inc di

; o character
mov ax, 0x0A6F  ; 0 = Black bck, A = Green bck, 6F = o
mov [es:di], ax




times 510-($-$$) db 0   ; Bootsector padding
dw 0xAA55               ; Final 2 bytes shold be AA55



