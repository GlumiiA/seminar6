section .data
x dq 2.2
num1000 dq 1000.0
k_interval_0_3 dq -1.0
b_interval_0_3 dq 3.0
result dq 40

section .text
    global _start

_start:
movsd xmm0, qword [x]             ; загружаем x в xmm0
movsd xmm1, qword [num1000]    ; загружаем 1000 в xmm1
mulsd xmm0, xmm1                   ; xmm0 = x * 1000.0
cvtsd2si rdi, xmm0                 ; в целое число (int(x * 1000))

; в rdi значение
function_y:
    test rdi, rdi  
    jge .positive 
    .positive:
    cmp rdi, 3000
    jle .interval_0_3 

.interval_0_3:
    ; х уже лежит на стеке
    fld dword[k_interval_0_3]
    fmulp
    fld dword[b_interval_0_3]
    faddp
    fstp dword [r8] ; сохраняем число y в result

    mov rdi, r8  ; в rdi результат вычислений
    call print_string

string_length:
    xor rax, rax
    ret
    .loop:
        cmp byte [rdi + rax], 0
        je .retLength
        inc rax
        jmp .loop
    .retLength:
        ret

print_string:
    xor rax, rax
    push rdi 
    call string_length 
    pop rdi;
    mov rsi, rdi
    mov rdi, 1 ; stdout
    mov rdx, rax ; длина строки
    mov rax, 1 ; write
    syscall

    ret

exit:
    mov     rax, 60                         
    syscall 

