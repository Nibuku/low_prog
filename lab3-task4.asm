section .data
array: dd 1, 1
two_arr: dq 3 ,0x7F800000, 0x7FFFFFFF

section .text 
;  namespace var5 {
;       struct S {
;           int one;
;           int two;}
;       class C {
;           size_t size;
;           float* arr;
;
;           check( S *a1){
;               float* r13;  
;               float* rbx;
;               float* rdi;
;               int esi=0;
;               bool result;
;               r13=arr;
;               if (arr){
;                   rbx=arr;
;                   rdi=r13[size];
;                   while(rbx !=rdi) {
;                       esi-=(isnan(*rbx)==0)-1;
;                       rbx++; }
;               else { esi=0;}
;               if (a1->one==esi){
;                   result=(a1->two==isinf(*r13));}
;               return result; }
;        }
;       void access5(S& a1, const float* arr){
;           int eax=a1.one*a1.two;
;           float* new_arr=arr;
;           if (eax==0)
;               check(0);
;           tmp=C::check(a1, new_arr);
;           return check(tmp);}
;}
;  
section .text
global main
extern access5
main:

sub rsp, 40

lea rcx, [array]
lea rdx, [two_arr]

movups xmm0, [rdx+8]
movups [rsp+16], xmm0
lea rax, [rsp+16]
mov [rdx+8], rax

call access5
add rsp, 40
ret