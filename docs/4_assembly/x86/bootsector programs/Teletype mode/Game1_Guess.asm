; nasm Game1_Guess.asm
; qemu-system-i386 -fda Game1_Guess

org 0x0100

; Generate and save a number between 0 and 7
start:
	in al,(0x40)    ; Get a random byte into AL (by reading the timer counter)
	and al, 0x07    ; Mask bits so value becomes 0-7 (in binary)
	add al, 0x30    ; Convert into ASCII digit
	mov cl, al      ; Save AL into CL

; Try to guess the number pressing 0-7 keys
game_loop:
	mov al, "?"
	call display_ascii_letter_from_AL
	call read_ascii_key_into_AL
	cmp al, cl      ; Compare input with generated number

	jne game_loop   ; If not equal, try again

	; If equal, success -> Then show hidden number
	call display_ascii_letter_from_AL

	; Also display a happy face :)
	mov al, ":"
	call display_ascii_letter_from_AL
	mov al, ")"
	call display_ascii_letter_from_AL



%include "library.asm" ; NASM

times 510-($-$$) db 0   ; Bootsector padding
dw 0xAA55               ; Final 2 bytes shold be AA55