.global main
.global my_strlen

.text

my_strlen:
    pushq %rbp
    xor %rax, %rax

    movq %rdi, %rbx

loop:
    // \0 = quit
    cmpb $0, (%rbx)
    je quit

    // Incr len and move pointer
    addq $1, %rbx
    addq $1, %rax

    jmp loop

quit:
    popq %rbp
    ret

main:
    movq $message, %rdi

    call my_strlen

    ret

message:
    .asciz "Hello world"
