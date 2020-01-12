section .text
global _main 

_main:
	mov eax, 0

main_loop:
	push eax
	or ax, ax
	aaa
	call putnumhex
	pop eax
	inc eax
	
	cmp eax, 16 
	jne main_loop

	mov al, 0
	ret

putnumhex: ; eax
	mov cx, 16
putnum_l1:
	sub cx, 4
	push eax
	push cx
	shr eax, cl
	and eax, 15
	call putnum1
	pop cx
	pop eax
	inc cx
	dec cx
	jnz putnum_l1	
	call putret
	ret

putnum1: ; eax 0-15
	mov ecx, NUMBERS ; address
	add ecx, eax
	mov eax, 4 ; syscall 4 (write)
	mov ebx, 1 ; stdout
	mov edx, 1 ; size
	call syscall_param3
	ret

putret:
	mov ecx, RETCODE ; address
	mov eax, 4 ; syscall 4 (write)
	mov ebx, 1 ; stdout
	mov edx, 1 ; size
	call syscall_param3
	ret

syscall_param3:
	push dword ebp
	mov ebp, esp
	push dword edx
	push dword ecx
	push dword ebx
	sub esp, 4 ; for Mac
	int 0x80
	add esp, 16
	pop ebp
	ret

SECTION .data
	NUMBERS db `0123456789ABCDEF`
	RETCODE db `\n`
