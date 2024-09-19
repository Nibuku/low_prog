%include "io64.inc"

section .data
seed: dd 0, 123456789, 362436069, 521288629
space: db ' ', 0

section .text
global main
main:
    ;Переменные:
    ; seed[0] edx
    ; seed[1]
    ; seed[2]
    ; seed[3]
    ; n - r8d
    ; i - ecx
    ; t - eax
    ; s - ebx
    ; tmp -r9d
    ; s_tmp - r10d
    
    GET_UDEC 4, r8d
    GET_DEC 4, [seed]
    xor ecx, ecx
.cycle_start:
  
  cmp ecx, r8d
  je .cycle_end
  mov eax, [seed+12]
  mov ebx, [seed]
  
  mov edx, [seed+8]
  mov [seed+12], edx

  mov edx, [seed+4]
  mov [seed+8], edx
  mov [seed+4], ebx
  

  
  mov r9d, eax
  sal r9d, 11
  xor eax, r9d
  
  mov r9d, eax
  sar r9d, 8
  xor eax, r9d
  
  mov r10d, ebx
  sar r10d, 19
  xor eax, ebx
  xor eax, r10d
   
  mov [seed], eax
  PRINT_DEC 4, [seed]
  PRINT_STRING space
  
  add ecx, 1
  jmp .cycle_start
  
    
.cycle_end:
  xor r9d, r9d
  xor r10d, r10d
    xor rax, rax
    ret