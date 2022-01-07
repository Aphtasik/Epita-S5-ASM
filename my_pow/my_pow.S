.global my_pow
.text

my_pow:
        // init
        pushq   %rbp
        movq    %rsp, %rbp
        subq    $32, %rsp
        movl    %edi, -20(%rbp)

        // init res 
        movl    $1, -4(%rbp)

        // print
        movl    -4(%rbp), %eax
        movl    %eax, %esi
        movl    $format, %edi
        movl    $0, %eax
        call    printf

        jmp     quit
loop:
        // mul
        sall    -4(%rbp)

        // print
        movl    -4(%rbp), %eax
        movl    %eax, %esi
        movl    $format, %edi
        movl    $0, %eax
        call    printf

        // decr
        subl    $1, -20(%rbp)
quit:
        // check if loop
        cmpl    $0, -20(%rbp)
        jg      loop
        
        //end
        nop
        nop
        leave
        ret

format:
        .asciz "%d\n"
