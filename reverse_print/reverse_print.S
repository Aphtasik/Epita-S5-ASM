.global reverse_print
.global main

.text

reverse_print:
    // Void Function that take an str from rdi and print it.
    pushq %rbp

    // copy message on rbx
    movq %rdi, %rbx

    // get length of message
    call strlen
    movl %eax, %ebp

    addq %rbp, %rbx

printchar:
    movb (%rbx), %dil
    call putchar

    dec %rbp // decrement length 
    subq $1, %rbx
    // clearing registers
    cmpl $-1, %ebp
    jne printchar
    jmp quit

quit:
    popq %rbp
    ret

main:
    movq $message, %rdi

    call reverse_print

    ret

message:
    .asciz "abcdefghijklmnop"
