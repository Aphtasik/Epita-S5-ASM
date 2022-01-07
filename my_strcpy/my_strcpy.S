.global my_strcpy
.global main

.text

my_strcpy:
    pushq %rbp
    // pointer that we will 
    movq %rsi, %rbx
    movq %rsi, %rax

loop:
    // check if \0
    cmpb $0, (%rbx)
    je quit
    // else copy and loop
    movb (%rbx), %dil
    addq $1, %rbx
    addq $1, %rdi
    jmp loop
quit:
    // set \0 at the end of str
    movb $0, (%rdi)
    // restore registers
    popq %rbp
    // return because rax is already set
    ret

main:
    movq $message, %rsi
    call my_strcpy
    movq %rax, %rdi
    call print
    xor %rax, %rax
    ret

print:
    // save le res sur la stack
    push %rax

    // Format string
    movq $format, %rdi
    movq %rax, %rsi

    // met a 0 rax, car printf fonction variadique et faut pas qu'il chope des truc derriere
    xor %rax, %rax

    call printf

    pop %rax

format:
    .asciz "%s\n"

message:
    .asciz "coucou c'est moi"
