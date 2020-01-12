section .data 
  message db 'Hello, World!', 0x0a
  length equ $ -message 

section .text
global _main

_main:
  mov     ecx, message
  mov     edx, length
  mov     ebx, 1
  mov     eax, 4
  call syscall_param3

  mov eax, 0
  ret

syscall_param3:
    push dword ebp
    mov ebp, esp
    push dword edx
    push dword ecx
    push dword ebx
    sub esp, 4
    int 0x80
    add esp, 16
    pop ebp
    ret
