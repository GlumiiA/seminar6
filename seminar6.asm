section .data
x dd 2.2
num1000 dd 1000
k_interval_0_3 dd -1
b_interval_0_3 dd 3

section .text

exit:
    mov     rax, 60                         
    syscall 

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

; в rdi значение
function_y:
    test rdi, rdi ; проверяем на знак
    jge .positive 
    .posetive:
    cmp rdi, 3
    jle .interval_0_3 

.interval_0_3:
    call mul_x1000
    ; х уже лежит на стеке
    fld dword[k_interval_0_3]
    fmulp
    fld dword[b_interval_0_3]
    faddp
    fstp dword [rdi] ; сохраняем число y в rdi

    call print_string


mul_x1000:
    fld dword [x]
    fld dword [num1000]
    fmulp
    fstp dword [x]

    ret


