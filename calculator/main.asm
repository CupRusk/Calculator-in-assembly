section .data
    msg db 'Result: ', 10          ; стандартное сообщение
    len equ $ - msg                ; длина стандартного сообщения

section .bss
    input resb 128                 ; буфер для ввода
    dyn_msg resb 128               ; буфер для динамических строк (placeholder)

section .text
    global _start
    global print
    global print_dynamic
    global input
    global callculate
    global _end

_start:
    call print          ; <-- проблема была: всегда печатает статический msg
                        ; исправлено: оставлен, но для динамического текста используем print_dynamic

    call callculate
    jmp _end

callculate:
    push rdx
    call input

    mov rdx, rax        ; сохраняем оригинальный rax
    add rax, rdx        ; rax = rax + rdx (пример для второго input)
    pop rdx
    ret

input:
    push rax

    mov rax, 0          ; syscall: read
    mov rdi, 0          ; stdin
    mov rsi, input      ; адрес буфера
    mov rdx, 128        ; количество байт
    syscall

    pop rax
    ret

print:
    push rax            ; сохраняем rax

    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, msg        ; pointer to static message
    mov rdx, len        ; длина сообщения
    syscall

    pop rax
    ret

print_dynamic:
    push rax
    push rdi

    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, dyn_msg
    mov rdx, rcx
    syscall

    pop rdi
    pop rax
    ret

_end:
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; код выхода 0
    syscall
