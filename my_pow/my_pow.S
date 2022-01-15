.global my_pow
.global main
.text

my_pow:
        cmp $0, %rdi
        je quit_print

        // init
        pushq   %rbp
        pushq   %rbx

        movl $1, %ebp
        movq %rdi, %rbx
        addq $1, %rbx

loop: 
        // print
        movl    %ebp, %esi
        movl    $format, %edi
        movl    $0, %eax
        call    printf

        dec %ebx
        imul $2, %ebp
    
        cmpl $0, %ebx
        je quit

        jmp loop

quit:
        // init
        popq   %rbp
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
