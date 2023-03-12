
; nasm Invaders.asm
; qemu-system-i386 -fda Invaders


; Minuto 48:28 https://youtu.be/TVvTDjMph1M?t=2548

use16
org 0x7C00        ; Bootsector needs to start at address 7C00 of RAM

; ====================================================
; ==================================================== CONSTANTS
; ====================================================

; ________________________ DIMENSIONS

SCREEN_HEIGHT   equ 200 ; Height in pixels
SCREEN_WIDHT    equ 320 ; Widht in pixels

SCALING         equ   2 ; Miniblock = 2x2 pixels

SPRITE_HEIGHT   equ   6 ; 6 vertical miniblocks
SPRITE_WIDHT    equ   8 ; 8 horizontal miniblocks

ALIEN_VERT_SEP  equ   6 ; 6 vertical miniblocks
ALIEN_HORZ_SEP  equ   6 ; 6 horizontal miniblocks

NUMBER_HORZ_ALIENS equ 11;8
NUMBER_VERT_ALIENS equ 5;4

PLAYER_SPEED  equ 4
; ________________________ PALETTE COLORS

BLACK         equ 0x00
LIGHT_GREY    equ 0x07
DARK_GREY     equ 0x08
LIGHT_BLUE    equ 0x0B
WHITE         equ 0x0F
DARK_BLUE     equ 0x20
PURPLE        equ 0x22
RED           equ 0x28 ; 0x04
ORANGE        equ 0x2A
YELLOW        equ 0x2C ; 0E
GREEN         equ 0x2E

; ________________________ SPRITES COLORS

COLOR_ALIEN      equ GREEN
COLOR_BARRIER    equ ORANGE
COLOR_PLAYER     equ LIGHT_GREY
COLOR_ALIEN_SHOT equ YELLOW


; ________________________ SPRITES FIXED POSITIONS

BARRIER_X equ 22 ; (pixel 22*2=44)
BARRIER_Y equ 85 ; (pixel 85*2=170)
PLAYER_Y  equ 93 ; (pixel 93*2=186)



; ________________________ MEMORY POINTERS

; Code Segment:
; FROM 0x00000 TO 0x0FFFF
; Used by IP
CS_POINTER equ 0x0000
	POINTER_TIMER      equ 0x046C ; 2 bytes: Number of timer ticks since midnight
	POINTER_CODE_START equ 0x7C00 ; 512 bytes (bootsector game)

; Data Segment:
; FROM 0xA0000 TO 0xAFFFF
; Used by BX, SI, DI

; Extra data Segment:
; FROM 0xA0000 TO 0xAFFFF
; Used by BX, SI, DI
ES_POINTER equ 0xA000
	POINTER_VIDEO_MEM           equ 0x0000 ; 64000 bytes = 320x200 pixels 
	ES_POINTER_DATA             equ 0xFA00
	POINTER_ALIEN1_SPRITE       equ ES_POINTER_DATA +  0 ; 6 bytes
	POINTER_ALIEN2_SPRITE       equ ES_POINTER_DATA +  6 ; 6 bytes
	POINTER_PLAYER_SPRITE       equ ES_POINTER_DATA + 12 ; 6 bytes
	POINTER_PLAYER_VIDEO_POS    equ ES_POINTER_DATA + 18 ; 2 bytes
	POINTER_PLAYER_X            equ ES_POINTER_DATA + 18 ; 1 byte
	POINTER_BARRIER_SPRITE      equ 0xFA0C ; 20 bytes = 4 bytes per sprite * 5 barriers
	POINTER_ALIENS_ARRAY        equ 0xFA20 ; 4 bytes (A number of 32 bits)
	POINTER_SHOTS_XY            equ 0xFA25 ; 8 bytes = 4 [x,y] shot values
	POINTER_ALIENSBLOCK_Y       equ 0xFA2D ; 1 byte
	POINTER_ALIENSBLOCK_X       equ 0xFA2E ; 1 byte
	POINTER_NUMBER_ALIENS_ALIVE equ 0xFA2F ; 1 byte
	POINTER_ALIENS_X_DIRECTION  equ 0xFA30 ; 1 byte: -5 or +5 horizontal pixels direction
	POINTER_MOVE_TIMER          equ 0xFA31 ; 2 bytes (using BP) number of game loops (or timer ticks) before aliens move
	POINTER_ALIENS_CHANGE       equ 0xFA33 ; 1 byte: Use ALIEN1 or ALIEN2 sprite



;..........................................   _____ ____  _____  ______ 
;..........................................  / ____/ __ \|  __ \|  ____|
;.......................................... | |   | |  | | |  | | |__   
;.......................................... | |   | |  | | |  | |  __|  
;.......................................... | |___| |__| | |__| | |____ 
;..........................................  \_____\____/|_____/|______|
                             
                             
;
; Assuming
; - Direction flag is clear, (so string operation increments counter)
; - SP (Stack Pointer) initialized to 0x6EF0
; - BP (Base Pointer) equals 0

call game_init

;========================================= GAME LOOP
game_loop: 

	;_______________________________ 1) GET USER INPUT
	call read_keyboard
	;call check_if_shot

	;_______________________________ 2) DO ALIENS LOGIC
	;call logic_alien_shots
	;call logic_alien_move

	;_______________________________ 3) DRAW FUNCTIONS
	call clear_screen_to_black
	;call delay_timer ; FOR DEBUGING PURPOSES (REMOVE THIS LINE)
	
	call draw_aliens
	;call draw_barriers
	call draw_player
	;call check_if_shots_collision
	;	call hit_player
	;	call hit_barrier
	;	call hit_alien
	;call draw_shots ; If shots dindnt hit anything -> Draw them

	;_______________________________ 4) DELAY (18.5 FPS)
	call delay_timer

	jmp game_loop






;............................................  ______                _   _                 
;............................................ |  ____|              | | (_)                
;............................................ | |__ _   _ _ __   ___| |_ _  ___  _ __  ___ 
;............................................ |  __| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
;............................................ | |  | |_| | | | | (__| |_| | (_) | | | \__ \
;............................................ |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/

game_init:
	set_video_mode:
		mov ax, 0x0013     ; MODE AL=13: 320x200 256 colors
		int 0x10           ; Call Bios Interruption

	copy_mem_from_CS_to_ES:
		mov ax, ES_POINTER ; Video mem starts at 0xA00000 (frame buffer)
		mov es, ax         ; ES  = 0xAXXXX
		; DS  = 0x0XXXX
		mov si, CS_POINTER_DATA ; Source:      Code Segment
		mov di, ES_POINTER_DATA ; Destination: Extra Segment 0xFA00
		mov cl, 22 ; Only firsts 3 sprites * 4 bytes each = 12 bytes
		rep movsb  ; Move data from DS:SI to ES:DI

		mov ds, ax         ; DS = ES = 0xAXXXX
	ret


; The int 0x16, ah =0x00
; - (if no key was pressed) WAIT until the user presses a key.
; - UPDATE the key from the buffer


; The int 0x16, ah = 0x01
;´- doesn't remove the key from the buffer, and (if no key was pressed) doesn't wait until the user presses a key.

; https://stackoverflow.com/questions/61484543/how-to-clear-data-from-keyboard-buffer-after-dos-int-16h-ah-1-detects-a-keypre
; https://stackoverflow.com/questions/58822549/int-16h-ah-1-repeatedly-gives-the-same-key-press-even-after-user-presses-another
; https://youtu.be/wQfOYeZDKWk?t=2323
read_keyboard:
	mov ah, 1  ; AH = 1
	int 16h    ; Get keyboard status
	jz end_keyboard; If no key was pressed, move on
	
	xor ah, ah ; AH = 0
	int 16h    ; Get key. AH = scanCode, AL= ascii char

	cmp al, "w"   ; IF key==W
	je w_pressed
	cmp al, "a"   ; ELSE IF key==A
	je a_pressed
	cmp al, "s"   ; ELSE IF key==S
	je s_pressed  
	cmp al, "d"   ; ELSE IF key==D
	je d_pressed
	cmp al, " "   ; ELSE IF key==D
	je space_pressed
	jmp end_keyboard  ; ELSE

	horizontal_moves:
		a_pressed:
			; DO SOMETHING. Eg mov bl, 1
			sub word [POINTER_PLAYER_VIDEO_POS], 1*PLAYER_SPEED
			jmp end_keyboard

		d_pressed:
			add word [POINTER_PLAYER_VIDEO_POS], 1*PLAYER_SPEED
			; DO SOMETHING. Eg mov bl, 3
			jmp end_keyboard

	vertical_moves:
		w_pressed:
			; DO SOMETHING. Eg mov bl, 0
			sub word [POINTER_PLAYER_VIDEO_POS], 320*PLAYER_SPEED
			jmp end_keyboard

		s_pressed:
			; DO SOMETHING. Eg mov bl, 2
			add word [POINTER_PLAYER_VIDEO_POS], 320*PLAYER_SPEED
			jmp end_keyboard



	space_pressed:
		; DO SOMETHING. Eg mov bl, 3
		jmp $
		jmp end_keyboard

	end_keyboard:
		ret


;get_player_input:
;	;read_keyboard:
;	mov ah, 1  ; Non Blocking mode: For detecting if some kay is pressed
;	int 0x16   ;
;	jz continue
;		; KEY WAS PRESSED -> FIND WHICH ONE
;		mov ah, 0 ; Blocking mode
;		int 0x16
;		; AL = ASCII CODE OF PRESSED KEY
;
;		; SPACE PRESSED?
;		cmp al, "a" ; SPACE "a"
;		je player_move_left
;
;		cmp al, "d" ; SPACE "a"
;		je player_move_right
;
;		cmp al, " " ; SPACE "a"
;		je player_shoot
;
;	continue:
;	ret


clear_screen_to_black:
	xor ax, ax      ; ax = 0 (COLOR BLACK in 256 colors palette)
	xor di, di      ; Destination Index = 0 (SCREEN POINTER)
	mov cx, SCREEN_WIDHT*SCREEN_HEIGHT ; Counter for all pixels (COUNTER)
	rep stosb       ; [ES:DI] = AL; DI++   (CX numeber of times)
	; [ES:DI] now points to AFA00
	ret


; Inputs
; - SI: Pointer to sprite adress (4x8 pixels = 4 bytes = 32 bits)
; - DI: Pointer to memory video position
; - BL: Color   (1 byte)
draw_sprite:

	mov bh, bl            ; Copy color byte on bh. BH = BL = COLOR
	mov cl, SPRITE_HEIGHT ; CL = OUTER COUNTER: 4 ROWS
	
	draw_next_row:
		lodsb                ; AL = [SI] (Load sprite row into AL); SI++
		mov dl, SPRITE_WIDHT ; DL = INNER COUNTER: 8 COLUMNS
		draw_next_pixel:
			dec dx
			bt ax, dx        ; Bit Test: If bit=1 -> Set carry flag
			jnc not_draw
			draw:
				mov [di], bx              ; Condintional Move if the carry is set
				mov [di+SCREEN_WIDHT], bx ; Condintional Move if the carry is set
			not_draw:
				add di, SCALING
			cmp dx, 0
			jnz draw_next_pixel

		;inc si (already done)
		add di, SCREEN_WIDHT*SCALING - SPRITE_WIDHT*SCALING
		loop draw_next_row

	ret


draw_player:
	
	mov si, POINTER_PLAYER_SPRITE; - SI: Pointer to sprite adress (4x8 pixels = 4 bytes = 32 bits)
	mov di, [POINTER_PLAYER_VIDEO_POS]; - DI: Pointer to memory video position
	mov bl, COLOR_PLAYER; - BL: Color   (1 byte)
	
	call draw_sprite
	ret

; Inputs
; - SI: Pointer to sprite adress (4x8 pixels = 4 bytes = 32 bits)
; - DI: Pointer to memory video position
; - BL: Color   (1 byte)
draw_aliens:

	mov si, POINTER_ALIEN2_SPRITE; - SI: Pointer to sprite adress (4x8 pixels = 4 bytes = 32 bits)
	mov di, 4*320+4; - DI: Pointer to memory video position
	mov bl, COLOR_ALIEN; - BL: Color   (1 byte)

	;;;;;;;;;;;;;;;;;; LOOP 4 ROWS OF ALIENS
	mov cl, NUMBER_VERT_ALIENS
	
	draw_next_aliens_row:

		mov dl, NUMBER_HORZ_ALIENS

		draw_next_alien:

			pusha
			; Inputs
			; - SI: Pointer to sprite adress (4x8 pixels = 4 bytes = 32 bits)
			; - DI: Pointer to memory video position
			; - BL: Color   (1 byte)
			call draw_sprite
			popa
			;       _______MOVE VIDEO POINTER RIGHT________
			add di, (SPRITE_WIDHT + ALIEN_HORZ_SEP)*SCALING
			dec dl
			jnz draw_next_alien

				;_______________MOVE VIDEO POINTER DOWN_____________________    __________________MOVE  VIDEO POINTER LEFT____________________
		add di, ((SPRITE_HEIGHT + ALIEN_VERT_SEP) * SCREEN_WIDHT * SCALING ) - ( (SPRITE_WIDHT+ALIEN_HORZ_SEP) * NUMBER_HORZ_ALIENS * SCALING )
		loop draw_next_aliens_row
	ret




; Delay timer:
; 1 tick delay (there are 18.5 ticks per second)
delay_timer:
	mov ax, [CS:POINTER_TIMER] ; Number of ticks since midnight
	inc ax
	;inc ax ; FOR DEBUGING PURPOSES (REMOVE THIS LINE)
	;inc ax ; FOR DEBUGING PURPOSES (REMOVE THIS LINE)
	;inc ax ; FOR DEBUGING PURPOSES (REMOVE THIS LINE)
	.wait_for_next_tick:
		cmp [CS:POINTER_TIMER], ax
		jl .wait_for_next_tick
	ret


game_end:
	cli
	hlt


; ============================================ CODE SEGMENT DATA

CS_POINTER_DATA:
	; Every square will be a 2x2 pixel

	alien_1:
		db 01000010b ;   ██        ██
		db 00111100b ;     ████████
		db 01011010b ;   ██  ████  ██
		db 11111111b ; ████████████████
		db 01000010b ;   ██        ██
        db 00100100b ;     ██    ██

	alien_2:
		db 00011000b ;       ████
		db 00111100b ;     ████████
		db 01011010b ;   ██  ████  ██
		db 11111111b ; ████████████████
		db 00100100b ;     ██    ██
		db 01000010b ;   ██        ██

	player:
		db 10011001b ; ██    ████    ██
		db 01111110b ;   ████████████
		db 00111100b ;     ████████
		db 00111100b ;     ████████
		db 00100100b ;     ██    ██
		db 00100100b ;     ██    ██

	player_video_pos:
		dw 180*320+160


	player_2:
		db 00011000b ;       ████
		db 01111110b ;   ████████████
		db 10111101b ; ██  ████████  ██
		db 00100100b ;     ██    ██


	barrier:
		db 00111100b ;     ████████
		db 01111110b ;   ████████████
		db 11100111b ; ██████    ██████
		db 11100111b ; ██████    ██████

	aliens_array:
		db 11111111b ; ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ There are
		db 11111111b ; ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ 32 aliens
		db 11111111b ; ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀
		db 11111111b ; ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀

	player_x:     db 70
	shots_array   db 0, 0, 0, 0, 0, 0, 0, 0
	aliens_y      db 10
	aliens_x      db 35
	aliens_num    db 32
	aliens_dir    db 0xFB ; -5 (to the left)
	aliens_vel    dw 18
	aliens_sprite db 1


times 510-($-$$) db 0   ; Bootsector padding
dw 0xAA55               ; Final 2 bytes shold be AA55




; https://fsymbols.com/es/generadores/tarty/




;  █▀▀█  ▄█    █▀█   █▀▀█   ▄▀█  █▀▀▀  ▄▀▀▀  ▀▀▀█  ▄▀▀▄  ▄▀▀▄  
;  █  █   █     ▄▀   ▄ ▀▄  █▄▄█  ▀▀▀▄  █▀▀█   ▄▀   ▄▀▀▄   ▀▀█   
;  ▀▀▀▀  ▀▀▀   ▀▀▀▀  ▀▀▀▀     ▀  ▀▀▀    ▀▀    ▀     ▀▀    ▀▀ 

;  █▀▀█  █▀▀▄  █▀▀█  █▀▀▄  █▀▀▀  █▀▀▀  █▀▀▀  █  █  ▀█▀     █  █ ▄▀  █     █▀▄▀█  █▄  █ 
;  █▄▄█  █▀▀▄  █  ▄  █  █  █▀▀   █▀▀   █ ▀█  █▀▀█   █   ▄  █  █▀▄   █     █ ▀ █  █ ▀▄█ 
;  ▀  ▀  ▀▀▀   ▀▀▀▀  ▀▀▀   ▀▀▀▀  ▀     ▀▀▀▀  ▀  ▀  ▀▀▀  ▀▀▀▀  ▀  ▀  ▀▀▀▀  ▀   ▀  ▀   ▀

;  █▀▀█  █▀▀█  █▀▀█  █▀▀▄  █▀▀▀  █▀▀▀  █▀▀█  █  █ ▀█▀     █  █ ▄▀  █     █▀▄▀█  █▄  █ 
;  █▄▄█  █▀▀▄  █     █  █  █▀▀▀  █▀▀▀  █ ▄▄  █▀▀█  █   ▄  █  █▀▄   █     █ █ █  █ █ █ 
;  █  █  █▄▄█  █▄▄█  █▄▄▀  █▄▄▄  █     █▄▄█  █  █ ▄█▄  █▄▄█  █  █  █▄▄█  █   █  █  ▀█