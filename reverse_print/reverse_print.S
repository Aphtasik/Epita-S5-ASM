.global reverse_print
.global main

.text

reverse_print:
    // Void Function that take an str from rdi and print it.
    pushq %rbp

    // copy message on rbx
    xor %rbx, %rbx
    movq %rdi, %rbx

    // get length of message
    call strlen
    movl %eax, %ebp
    dec %ebp

    addq %rbp, %rbx

printchar:
    movb (%rbx), %dil
    call putchar

    subq $1, %rbx
    dec %rbp // decrement length 

    // clearing registers
    cmpl $-1, %ebp
    jne printchar

quit:
    popq %rbp
    movq $0, %rax
    ret

main:
    xor %rdi, %rdi
    movq $message, %rdi

    call reverse_print

    ret

message:
    .asciz "I love pagnou_P"
