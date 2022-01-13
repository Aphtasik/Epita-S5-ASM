.global my_strcpy
.global main

.text

my_strcpy:
    pushq %rbp
    // pointer that we will 
    xor %rax, %rax
    xor %r15, %r15
    movq %rdi, %rax

loop:
    // check if \0
    cmpb $0, (%rsi)
    je quit
    // else copy and loop
    movq (%rsi), %r15
    movq %r15, (%rdi)

    addq $1, %rdi
    addq $1, %rsi

    jmp loop

quit:
    // set \0 at the end of str
    movb $0, (%rdi)

    // restore registers
    popq %rbp

    // return because rax is already set
    nop
    ret
