

; nasm primes_numbers.asm
; qemu-system-i386 -fda primes_numbers

; Prime numbers algorithm:
; Sieve of Eratosthenes



; 1.  Start with 2
; 2.  Is prime?
; 3.     Show it as prime
; 4.     Mark all multimples as non prime
; 5.  Incremente current number
; 6.  We still dont have reached the limit?
; 7.     Got to step 2

org 0x7c00


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CODE
;
; sieve_of_eratosthenes:

print_1:
	mov al, "1"
	call display_ascii_from_AL

	mov al, " "
	call display_ascii_from_AL

initalization:
	mov ax, 2      ; Start with 2
	mov bx, table  ; 16 bit pointer to table adress
	mov cx, 200    ; Maximum limit to explore primes

main_loop:
	mov bx, table
	add bx, ax        ; BX = BX + AX
	cmp byte [bx], 1  ; 2.  Is prime?
	jne incremente_current_number

	do_prime:
		; 3. Show it as prime
		pusha
		call display_decimal_number_from_AX

		mov al, " "
		call display_ascii_from_AL

		popa


		; 4. Mark all multiples as non prime (= 0)
		pusha
		mark_next_multiple:
			add ax, ax     ; AX = AX + AX (this is the multiple)
			mov bx, table  ; 16 bit pointer to table adress
			add bx, ax
			mov byte [bx], 0

			cmp ax, cx   ; Limit reached ?
			jle mark_next_multiple
		popa

	incremente_current_number:
		inc ax

		cmp ax, cx   ; Limit reached
		jle main_loop
		jmp $


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; EXTERNAL CODE

%include "library.asm" ; NASM


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; DATA VARIABLES

table: times 200 db 1   



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; BOOTSECTOR ENDING

times 510-($-$$) db 0   ; Bootsector padding
dw 0xAA55               ; Final 2 bytes shold be AA55





