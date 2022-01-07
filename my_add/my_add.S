.global main //program accessible pour le link de l'exterieur
.global my_add
.text //partie ou on a le code assembleur

my_add:
    //save addresse de retour sur la stack
    pushq %rbp 

    // on recup les deux params
    movl %edi, %edx
    movl %esi, %eax

    // add les deux et les mets ds eax
    addl %edx, %eax

    // recup addresse de retour
    popq %rbp
    ret
    

main:
    // place les vars
    movl $42, %edi
    movl $50, %esi

    call my_add 


### Printf
    // save le res sur la stack
    push %rax

    // Format string
    mov $format, %rdi
    mov %rax, %rsi

    // met a 0 rax, car printf fonction variadique et faut pas qu'il chope des truc derriere
    xor %rax, %rax

    call printf

    pop %rax


### fin de main
    // on restaure rax pour le return 0
    mov $0, %rax
    ret


format:
    .asciz "%ld\n"
