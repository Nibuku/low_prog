
section .rodata
value: dd 20.0
a: dd 1.0
two_pi: dd 6.28319
factorials: dd 2.0, 24.0, 720.0,40320.0,3628800.0, \
            479001600.0, 87178291200.0, 20922789888000.0, \
            6402373705728000.0, 2432902008176640000.0,
               
section .bss
x: resd 1


section .text
global main
cos:
    
    movss xmm0, [value] 
    movss xmm4, [two_pi]
.cycle_start: 
    comiss xmm0,xmm4
    ja .cycle_end
    

    
    mulss xmm0, xmm0 ;x^2
    movss xmm1, xmm0  
    movss xmm2, xmm0 ; для последующ. возв. в степень
    movss xmm3, [a]
    divss xmm1, [factorials] ; x^2/2!
    subss xmm3, xmm1 ; a-x^2/2!
    

    
    mulss xmm2, xmm0 ;x^4
    movss xmm1, xmm2
    divss xmm1, [factorials+4] ;x^4/4!
    addss xmm3, xmm1
    
    mulss xmm2, xmm0 ; x^6
    movss xmm1, xmm2
    divss xmm1, [factorials+8]
    subss xmm3, xmm1
    
    mulss xmm2, xmm0 ;x^8
    movss xmm1, xmm2
    divss xmm1, [factorials+12]
    addss xmm3, xmm1
    
    mulss xmm2, xmm0 ;x^10
    movss xmm1, xmm2
    divss xmm1, [factorials+16]
    subss xmm3, xmm1
    
    mulss xmm2, xmm0 ;x^12
    movss xmm1, xmm2
    divss xmm1, [factorials+20]
    addss xmm3, xmm1
    
    mulss xmm2, xmm0 ;x^14
    movss xmm1, xmm2
    divss xmm1, [factorials+24]
    subss xmm3, xmm1
    
    mulss xmm2, xmm0 ;x^16
    movss xmm1, xmm2
    divss xmm1, [factorials+28]
    addss xmm3, xmm1
    
    mulss xmm2, xmm0 ;x^18
    movss xmm1, xmm2
    divss xmm1, [factorials+32]
    subss xmm3, xmm1
    
    mulss xmm2, xmm0 ;x^20
    movss xmm1, xmm2
    divss xmm1, [factorials+36]
    addss xmm3, xmm1
    
    movss [x], xmm3
    ret 
    
.cycle_end:
    subss xmm0, xmm4
    jmp .cycle_start
    
main:
    call cos
    xor rax, rax
    ret