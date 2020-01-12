SECTION .text
global _main 

_main:
	cpu 8086
	MOV AX, 5
	SHL AX, 1
	SHL AX, 1
	SHL AX, 1
	SHL AX, 1
	MOV BX, AX
	SHL AX, 1
	SHL AX, 1
	SHL AX, 1
	ADD AX, BX
	CALL putnum

	cpu 186
	MOV AX, 5
	SHL AX, 4 ; from 80186
	MOV BX, AX
	SHL AX, 3 ; from 80186
	ADD AX, BX
	CALL putnum

	cpu 8086
	MOV AX, 5
	MOV CL, 4
	SHL AX, CL
	MOV BX, AX
	DEC CL
	SHL AX, CL
	ADD AX, BX
	CALL putnum

	cpu 8086
	MOV AX, 5
	MOV BX, 144
	MUL BX
	CALL putnum

	MOV AL,0
	RET

	cpu IA64

putnum1: ; rax 0-15
	and rax, 0xf
	mov rsi, NUMBERS		;  buffer
	add rsi, rax
	mov rax, 0x2000004		; syscall 4: write
	mov rdi, 1				;  fd = stdout
	mov rdx, 1 ; size
	syscall
	ret

putret:
	mov rsi, RETCODE		;  buffer
	mov rax, 0x2000004		; syscall 4: write
	mov rdi, 1				;  fd = stdout
	mov rdx, 1 ; size
	syscall
	ret

putnum:
	call putnum_noret
	call putret
	ret
putnum_noret:
	xor dx, dx           ; DX=0
	mov cx, 10           ; Divisor = 10
	div cx               ; Divide (AX..DX=DX:AX/CX)
	or ax, ax            ; AX == 0?
	push dx              ; push remain
	je putnum_skip       ; if AX == 0 skip
	call putnum_noret    ; output left side
putnum_skip:
  pop ax
	jmp putnum1

	;mov rax, 0x1234567812345678
	;call putnumhex
	;ret
putnumhex: ; rax
	mov cx, 16 ; output 16bit
putnumhex_l1:
	sub cx, 4
	push rax
	push cx
	shr rax, cl
	and rax, 15
	call putnum1
	pop cx
	pop rax
	inc cx
	dec cx
	jnz putnumhex_l1	
	call putret
	ret

SECTION .data
	NUMBERS db `0123456789ABCDEF`
	RETCODE db `\n`
