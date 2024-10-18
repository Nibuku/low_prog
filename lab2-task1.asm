%include "io64.inc"

section .rodata
    value: dd 1.02 ;исходное число

section .bss
    result: resd 1 ;результат


section .text
    global main
    rounding_up_87:
        sub rsp,8 ;выделяем места на стеке
        fstcw [rsp]
        mov al, [rsp+1] ;помещаем старший байт в al
        and al,0xF3
        or al, 8
        mov [rsp+1], al
        fldcw [rsp]; сохраняем измения
        fld dword[value]
        fistp dword[result] 
        mov eax, [result] 
        PRINT_DEC 4, eax
        add rsp, 8
        xor eax, eax
        ret 
    
    sse:
        movss xmm0, dword[value]
        sub rsp, 4
        stmxcsr [rsp]    
        mov eax, [rsp]            
        or eax, 0x00004000            
        mov [rsp], eax        
        ldmxcsr [rsp]
        cvtss2si eax, xmm0      
        PRINT_DEC 4, eax  
        add rsp, 4     
        xor eax, eax     
        ret
        
    
    
    
main:
    call rounding_up_87
    NEWLINE
    call sse
    ret