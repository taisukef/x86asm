SECTION .text
global _main 

_main:
	mov rax, 5

	SHL AX, 1
	SHL AX, 1
	SHL AX, 1
	SHL AX, 1
	MOV BX, AX
	SHL AX, 1
	SHL AX, 1
	SHL AX, 1
	ADD AX, BX

	call putnumhex

	mov rax, 5
	
	MOV BX, 144
	MUL BX
	
	call putnumhex

	ret

	;mov rax, 0x1234567812345678
	;call putnumhex
	;ret

putnumhex: ; rax
	mov cx, 64
putnum_l1:
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
	jnz putnum_l1	
	call putret
	ret

putnum1: ; rax 0-15
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

putnum: ; rax
	mov bx, 10000
putnem_l1:
	push ax
	push bx
	mov dx, 0
	div bx
	call putnum1
	pop bx
	mov ax, bx
	mov bx, 10
	div bx
	pop ax
	inc bx
	dec bx
	jnz putnum_l1

	call putret
	ret

SECTION .data
	NUMBERS db `0123456789ABCDEF`
	RETCODE db `\n`

