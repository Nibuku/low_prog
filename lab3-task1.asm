section .rodata
space: db ' ', 0
string: db "%u", 0

section .text
global main
extern printf, scanf, malloc, free, puts
main:
    push rsi
    push rbx
    push rbp
    push r12
    push r13
    mov rbp, rsp
    sub rsp, 4+4+32+8
    
    
    lea rcx, [string]
    lea rdx, [rbp-4] ;нулевое зерно
    call scanf
    
    lea rcx, [string]
    lea rdx, [rbp-8] ;n
    call scanf
    
    mov rcx, 16
    call malloc
    mov rsi, rax
    
    ;изменяемые - r8-r11, rax, rcx,rdx xmm0-5
    
    ;Переменные:
    ;rsi - буффер
    ; seed[0] = [rsi]
    ; seed[1] = [rsi-4]
    ; seed[2] = [rsi-8]
    ; seed[3] = [rsi-12]
    ; n - r8d
    ; i - ecx
    ; t - eax
    ; s - ebx -неизменяемый
    ; tmp -r9d
    ; s_tmp - r10d
    mov dword[rsi+4], 10
    mov dword[rsi+8], 20
    mov dword[rsi+12], 30

    mov r12d, [rbp-8] ;n
    mov eax, [rbp-4] ; seed[0]
    mov [rsi], eax
    
    xor r13d, r13d
.cycle_start:
  
  cmp r13d, r12d
  je .cycle_end
  mov eax, [rsi+12]
  mov ebx, [rsi]
  
  mov r8d, [rsi+8]
  mov [rsi+12], r8d

  mov r8d, [rsi+4]
  mov [rsi+8], r8d
  mov [rsi+4], ebx
  
  
  mov r9d, eax
  shl r9d, 11
  xor eax, r9d
  
  mov r9d, eax
  shr r9d, 8
  xor eax, r9d
  
  mov r10d, ebx
  shr r10d, 19
  xor eax, ebx
  xor eax, r10d
   
  mov [rsi], eax
  
  lea rcx, [string]   ; строка формата
  mov rdx, rax        ; число для вывода (уже в eax, так что mov оптимален)
  call printf
  
  lea rcx, [space]
  call puts
  
  
  add r13d, 1
  jmp .cycle_start
  
    
.cycle_end:
  mov rcx, rsi
  call free
  
  xor rax, rax
  leave
  pop rsi
  pop rbx
  pop r12
  pop r13
  ret
    
    
    
    
