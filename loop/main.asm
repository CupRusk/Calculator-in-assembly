section .text
    global _start

_start:
    xor rcx, rcx            

loop_start:
    cmp rcx, 10
    jge loop_end
    
    push rcx                
    call print
    pop rcx                 
    
    inc rcx
    jmp loop_start

loop_end:
    mov rax, 60           
    xor rdi, rdi           
    syscall

print:
    push rax               
    push rdi
    push rsi
    push rdx
    
    mov rax, 1             
    mov rdi, 1             
    mov rsi, msg
    mov rdx, msg_len
    syscall
    
    pop rdx                
    pop rsi
    pop rdi
    pop rax
    ret

section .data
    msg: db "Hello world!", 0xA
    msg_len: equ $ - msg
