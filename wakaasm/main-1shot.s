bits 32

section .text
global _main

_main:
	push 0x616b6e61
	push 0x546d7341
	mov ecx, esp
	push 8    ; length
	push ecx  ; buffer
	push 1    ; stdout
	mov ax, 4 ; sys_write
	push eax  ; dummy
	int 0x80
	xor ax, ax
	add esp, 16 + 8
	ret
