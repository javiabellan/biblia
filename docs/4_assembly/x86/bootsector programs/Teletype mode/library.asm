read_ascii_key_into_AL:
	mov ah, 0x00
	int 0x16
	ret

display_ascii_from_AL:
	mov ah, 0x0e
	int 0x10
	ret

display_ascii_from_AL_graphic_mode:
	mov ah, 0x0e
	mov bx, 0x000f ; BH=00 -> Page zero; BL=0F -> Color (0: black background, F=White foreground)
	int 0x10
	ret

; Displays the value if AX as a decimal mumber
display_decimal_number_from_AX:

	init:
		mov bx, 10   ; BX = 10  -> Decimal divisor
		mov cx, 0    ; CX = 0   -> Counter for number of digits

	division_recursive_loop:
		mov dx, 0    ; DX = 0
		div bx       ; AX = DX:AX / BX     DX = DX:AX % BX
		inc cx       ; CX++
		push dx      ; Saves the remainder on the stack
		cmp ax, 0    ; If AX != 0 ...
		jne division_recursive_loop ; ... jump

	; If AX==0 print remainders in reverse order
	print_remainders_in_reverse_order:
		pop ax
		add al, "0" ; Convert to ASCII numerical char (add 30)
		call display_ascii_from_AL
		loop print_remainders_in_reverse_order ; CX-- and jnz 

	ret