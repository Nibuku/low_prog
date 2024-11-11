section .rodata
space: db ' ', 0
string: db "%u", 0

section .text
global main
extern printf, scanf, malloc, free, puts
main:
    push esi
    push ebx
    push ebp
    push edi
    mov ebp, esp
    sub esp, 4+4+8
    
    
    lea eax, [string]
    mov [esp], eax 
    lea eax, [ebp-4]
    mov [esp+4], eax
    call scanf
    
    lea eax, [string]
    mov [esp], eax 
    lea eax, [ebp-8]
    mov [esp+4], eax
    call scanf
    
    mov dword[esp], 16
    call malloc
    mov esi, eax
    
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
    mov dword[esi+4], 10
    mov dword[esi+8], 20
    mov dword[esi+12], 30

    ;mov edi, [ebp-8] ;n
    mov eax, [ebp-4] ; seed[0]
    mov [esi], eax
    
    xor edi, edi
.cycle_start:
  
  cmp edi, [ebp-8]
  je .cycle_end
  mov eax, [esi+12]
  mov ebx, [esi]
  
  mov edx, [esi+8]
  mov [esi+12], edx

  mov edx, [esi+4]
  mov [esi+8], edx
  mov [esi+4], ebx
  

  mov edx, eax
  shl edx, 11
  xor eax, edx
  
  mov edx, eax
  shr edx, 8
  xor eax, edx
  
  mov edx, ebx
  shr edx, 19
  xor eax, ebx
  xor eax, edx
   
  mov [esi], eax
  mov edx, eax
  
  lea eax, [string]
  mov [esp], eax       ; Помещаем адрес строки формата ("%u") в первый аргумент
  mov [esp+4], edx    ; Помещаем значение eax в стек для передачи в printf
  call printf


  lea eax, [space]
  mov [esp], eax       ; Помещаем адрес строки пробела в первый аргумент
  call puts
  
  
  add edi, 1
  jmp .cycle_start
  
    
.cycle_end:
  mov ecx, esi
  call free
  
  xor eax, eax
  leave
  pop esi
  pop ebx
  pop edi
  ret
    
    
    
    
