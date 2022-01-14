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
