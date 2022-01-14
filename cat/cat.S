.section .bss
        .equ SIZE, 1
        .lcomm BUFFER, SIZE
.global main
.global cat

.text

cat:
    pushq   %rbp
    xor %rax, %rax

    // Set args for open
    movq    %rsi, %rdi
    movq    $0, %rsi

    // Call open (path, flags) -> fd
    movq    $2, %rax
    syscall

    cmp $0, %rax
    jle err_open

    movq    %rax, %rbx // FD in RBX

read:
    movq    %rbx, %rdi // Get back FD from RBX

    // Set up Buffer
    movq    $BUFFER, %rsi
    movq    $SIZE, %rdx

    // Call Read (fd, buff) -> err
    movq    $0, %rax 
    syscall
    
    // Check EOF
    cmp    $0, %rax
    je     quit

write_cat:
    movq    $1, %rdi // FD STDOUT
    movq    $SIZE, %rdi

    // Write call (fd, buff) -> err
    call write

    jmp     read // Keep reading until \0

quit:
    popq %rbp

    // Call Close
    movq    $3, %rax 
    syscall

    movq $0, %rax
    ret


err_open:
    popq %rbp
    movq $2, %rax
    ret
    
err_args:
    movq $1, %rax
    ret


main:
    // Check if there is one arg
    cmp $2, %rdi
    jne err_args

    // Shift the file name to first place (might be a cleaner way tho)
    movq 8(%rsi), %rsi

    call cat

    ret


/*open:
        movl    $5, %eax        # open() system call
        movl    8(%esp), %ebx   # first argument
        movl    $0, %ecx        # intended for reading
        movl    $0666, %edx     # permission
        int     $0x80

read:
        movl    %eax, %ebx      # store fd for read()
        movl    $3, %eax        # read() system call
        movl    $BUFFER, %ecx   # store buffer address
        movl    $SIZE, %edx     # buffer size
        int     $0x80

        cmpl    $0, %eax        # EOF
        jle     close           # close

display:
        movl    %ebx, %ebp      # store fd into %ebp
        movl    $4, %eax        # write() system call
        movl    $1, %ebx        # fd STDOUT
        int     $0x80

        movl    %ebp, %eax      # move fd into %eax
        jmp     read            # continue reading

close:
        movl    $6, %eax        # close() system call
        movl    %ebp, %ebx      # move fd back into %ebx
        int     $0x80

exit:
        movl    $1, %eax        # exit() system call
        xorl    %ebx, %ebx      # return 0
        int     $0x80*/
