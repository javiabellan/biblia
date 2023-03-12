; Print Hello world in Tele-Type Mode
;
; Assembly:
;    fasm HelloWorld_2.asm
;
; Execute:
;     qemu-system-i386 -fda HelloWorld_2.bin


; Tell the assembler where this code will be loaded
org 0x7c00


jmp main

;;;;;;;;;;;;;;;;;;;;;;;;; Data


; 0x0D --> Carriage return
; 0x0A --> New line
; 0x00 --> Null char (End of string convention)

HELLO_MSG:   db "Hello, World!", 0x0D, 0x0A, 0x00
GOODBYE_MSG: db "Goodbye!", 0x00


;;;;;;;;;;;;;;;;;;;;;;;;; Functions

; Print string in Tele-type mode
; Parameters:
;    bx -> Pointer to first character of the string
;
print_string:
	mov ah, 0x0e     ; Set tele-type mode for the 10h interruption

	print_next_char:
		mov al, [bx] ; al = ASCII code of the char (1 byte)
		cmp al, 0    ; Check that the char is not 0 (null char)
		je print_end ; If character == 0 -> End of string -> Finish function
		int 0x10     ; Else: valid charater -> Call 10h Interruption to print it
		inc bx       ; Point to next character position in memory
		jmp print_next_char ; Loop back
	print_end:
		ret

;;;;;;;;;;;;;;;;;;;;;;;;; Main

main:
	mov bx, HELLO_MSG ; Use BX as a parameter to our function, so
	call print_string ; we can specify the address of a string.

	mov bx, GOODBYE_MSG
	call print_string

	jmp $               ; Infinite loop


times 510 -( $ - $$ ) db 0 ; Padding
dw 0xaa55                  ; Magic number