BITS 32

section .text
global _main

_main:
;41  73  6d  54  61  6e  6b  61
push 0x616b6e61
push 0x546d7341
mov ecx, esp
mov    ax , 4 ; sys_write
;    push ebp
;    mov ebp, esp
    push 8; length
    push ecx
    push 1; stdout
;    sub esp, 4
push eax
int 0x80
    add esp, 24;16
 ;   pop ebp
;pop ecx
xor ax,ax
ret
