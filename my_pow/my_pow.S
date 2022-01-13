.global my_pow
.global main
.text

my_pow:
        cmp $0, %rdi
        je quit_print

        // init
        pushq   %rbp
        pushq   %rbx
        pushq   %r12

        movl $1, %r12d
        movq %rdi, %rbx
        addq $1, %rbx

loop: 
        // print
        movl    %r12d, %esi
        movl    $format, %edi
        movl    $0, %eax
        call    printf

        dec %ebx
        imul $2, %r12
    
        cmpl $0, %ebx
        je quit

        jmp loop

quit:
        // init
        popq   %rbp
        popq   %r12
        popq   %rbx

        movq $0, %rax

        ret

quit_print:
        // print
        movl    $1, %esi
        movl    $format, %edi
        movl    $0, %eax
        call    printf
        
    
        movq $0, %rax

        ret

main:
    movq $5, %rdi
    call my_pow
    nop
    ret

format:
        .asciz "%d\n"
