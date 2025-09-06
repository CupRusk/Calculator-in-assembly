section .data
    msg_if db 'Hello from IF!', 10
    len_if equ $ - msg_if

    msg_else db 'Hello from ELSE!', 10
    len_else equ $ - msg_else

section .text
    global _start
    ; Будет как псевдокод:
    ; if (rax != 0) -> IF-branch
    ; else           -> ELSE-branch

_start:
    mov rax, 1          ; попробуй менять 0 / 1
    jmp _if             ; "вызов" if

_if:
    cmp rax, 0
    je _else            ; если rax == 0 → else

    mov rax, 1
    mov rdi, 1
    mov rsi, msg_if
    mov rdx, len_if
    syscall
    jmp _end

_else:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_else
    mov rdx, len_else
    syscall
    jmp _end

_end:
    mov rax, 60
    xor rdi, rdi
    syscall
