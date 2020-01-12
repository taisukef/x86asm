section .text
global _main 

_main:
	mov ax, 10
		
	mov bx, 0
loop:
	add bx, ax
	sub ax, 1
	jne loop

	mov ax, bx
	ret
