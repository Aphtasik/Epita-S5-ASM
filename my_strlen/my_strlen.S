.global main
.global my_strlen

.text

my_strlen:
    pushq %rbp

    xor %rbx, %rbx
    xor %rax, %rax
    movq %rdi, %rbx

loop:
    cmpb $0, (%rbx)
    je quit

    addq $1, %rbx
    addq $1, %rax

    jmp loop

quit:
    popq %rbp
    ret

main:
    xor %rdi, %rdi
    movq $message, %rdi

    call my_strlen

    ret

message:
    .asciz "Hello world"
