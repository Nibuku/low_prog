section .data
max_: dd 20


section .rodata

value: dd 2.6
a: dd 1.0

min_one: dd -1.0
two: dd 2.0
three: dd 3.0
two_pi: dd 6.28318530
  
section .bss
x: resd 1


section .text
global main
cos:
    
    movss xmm0, [value] 
    movss xmm4, [two_pi]
    movss xmm8, [a]
.cycle_start: 
    comiss xmm0,xmm4
    ja .cycle_sub
    
    mulss xmm0, xmm0 ;x^2
    mulss xmm0, [min_one] ;-x^2
    
    movss xmm3, [a] ;1 - нулевой член
    mov ecx, 1
.cycle_cos:   
    cmp ecx, [max_]
    je .cycle_end
    
    mov eax, ecx 
    shl eax, 1   
    mov edx, eax 
    sub eax, 1   
    mul edx      

    cvtsi2ss xmm9, eax
    movss xmm10, xmm0
    divss xmm10, xmm9 ;-x^2/2n(2n-1)
    mulss xmm8, xmm10 ;

    addss xmm3, xmm8

    
    add ecx, 1
    jmp .cycle_cos

    
.cycle_sub:
    subss xmm0, xmm4
    jmp .cycle_start
.cycle_end:
    movss [x], xmm3
    xor rax, rax
    ret
    
main:
    call cos
    xor eax, eax
    ret