;___________________________________
;
;  nasm Palette.asm
;  qemu-system-i386 -fda Palette
;___________________________________
;
; Show VGA palette
;
; Interruption 13h video mode:
;   320x200 (64000 pixels)
;   256 colors (1 byte per pixel)
;
; Video memory start at 0xA0000
; Video memory ends at 0xA000 + 64000 = 0xAFA00
;___________________________________________
;
; Draw pixels in that order:
;
; 1---2  9--10  13-14
; 3---4  -----  green .....
; 5---6  -blue  green
; 7---8  11-12  15-16
;
; 17-18  21-22
; ----   ----- .......
; ----   -----
; 19-20  23-24
;


use16
org 0x7C00        ; Needs to start at address 7C00 of RAM


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; INPUT VARIABLES

SQUARE_WIDHT  equ 15 ; Min = 1, Max = 20
SQUARE_HEIGHT equ 12 ; Min = 1, Max = 12


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CONSTANTS

SCREEN_WIDHT  equ 320
SCREEN_HEIGHT equ 200

; POINTERS TO VARIABLES
; From 0x0000 to 0xF9FF goes VIDEO MEMORY,
; So we can not use that space.
; 0xFA00 is the first free byte.
;
square_color_p  equ 0xFA00 ; 1 byte (from 0 to 256) <= 256
square_col_p    equ 0xFA01 ; 1 byte (from 0 to 20)  <= 256
square_row_p    equ 0xFA02 ; 1 byte (from 0 to 12)  <= 256
palette_row_p:  equ 0xFA03 ; 1 byte (from 0 to 12*16=192) <= 256
palette_col_p:  equ 0xFA04 ; 1 byte (from 0 to 12*16=192) <= 256
palette_idx_p:  equ 0xFA05 ; 2 bytes (from 0 to 320*200=64000) <= 65536


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CODE

init_video_mode:
	mov AH, 0x00  ; Set video mode specified on AL
	mov AL, 0x13  ; Set video mode ot 320x200 pixels with 256 colors
	int 0x10      ; Call the 10h interruption. See more at https://es.wikipedia.org/wiki/Int_10h

	mov ax, 0xA000 ;
	mov ds, ax     ; Set data segment to       0xA 0000
	; mov es, ax   ; Set extra data segment to 0xA 0000

init_variables:
	mov byte [square_color_p], 0
	mov byte [square_col_p],   0
	mov byte [square_row_p],   0
	mov byte [palette_col_p],  0
	mov byte [palette_row_p],  0
	mov word [palette_idx_p],  0


paint_palette:

	; STEP 1)
	; Paint current color on current palette_idx
	; palette_idx =   ( palette_row*SQUARE_WIDHT  + square_row ) * SCREEN_WIDHT
	;               + ( palette_col*SQUARE_HEIGHT + square_col )
	;
	mov al, [square_color_p]
	mov bx, [palette_idx_p]
	mov [bx], al ; PAINT on video mem


	; STEP 2) GO TO NEXT PIXEL

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; square_col++
	inc byte [square_col_p]  ; square_col++
	inc word [palette_idx_p]

	cmp byte [square_col_p], SQUARE_WIDHT
	jne paint_palette

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; square_col=0; square_row++
		mov byte [square_col_p], 0 ; square_col = 0
		inc byte [square_row_p]    ; square_row++
		add word [palette_idx_p], SCREEN_WIDHT - SQUARE_WIDHT

		cmp byte [square_row_p], SQUARE_HEIGHT
		jne paint_palette

			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; square_row=0; palette_col++; NEXT_COLOR
			mov byte [square_row_p], 0 ; square_row=0
			inc byte [palette_col_p]   ; palette_col++
			inc byte [square_color_p]  ; NEXT_COLOR
			;sub word [palette_idx_p], (SCREEN_WIDHT*SQUARE_HEIGHT) - SQUARE_WIDHT
			add word [palette_idx_p], - (SCREEN_WIDHT*SQUARE_HEIGHT) + SQUARE_WIDHT

			cmp byte [palette_col_p], 16
			jne paint_palette

				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; palette_col=0; palette_row++
				mov byte [palette_col_p], 0  ; palette_col=0
				inc byte [palette_row_p]     ; palette_row++
				add word [palette_idx_p], (SCREEN_WIDHT*SQUARE_HEIGHT) - SQUARE_WIDHT*16
				
				cmp byte [palette_row_p], 16
				jne paint_palette
				jmp end


end: jmp $



times 510-($-$$) db 0   ; Bootsector padding
dw 0xAA55               ; Final 2 bytes shold be AA55


