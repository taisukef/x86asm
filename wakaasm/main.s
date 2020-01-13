bits 32

section .text
global _main

_main:
	push 0x796c626d
	xor eax, eax
	push 0x65737341
	push 0x616b6157
	mov ecx, esp
	push 12   ; length
	push ecx  ; buffer
	push 1    ; stdout
	push eax  ; dummy
	mov al, 4 ; sys_write
	int 0x80
	jmp _main
