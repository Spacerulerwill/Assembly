# Assembly program to calculate hamming weight of a number (number of 1 bits)
# Build:
# gcc hamming_weight.s -o hamming_weight -static
# Run:
# ./hamming_weight

.text
.global main

.set number, 123123123              # number to find hamming weight 

main:
    mov $number, %rax               # store starting number in rax
    xor %rbx, %rbx                  # store number of one bits in rbx
                                    # while rax != 0 loop
    jmp loop_condition              # go to condition check of while loop
loop_content:                       # loop body
    mov %rax, %rcx                  # mov rax into rcx
    and $1, %rcx                    # bitwise and of 1 to check if it has trailing 1 bit
    add %rcx, %rbx                  # add the result of this to rbx
    shr $1, %rax                    # shift once to the right
loop_condition:                     # condition for while loop
    cmp $0, %rax                    # is rax and 0
    jne loop_content                # if rax not equal to zero, loop again
                                    # printf call
    mov $format, %rdi               # format is first argument
    mov %rbx, %rsi                  # the hamming weight is the second argument
    xor %rax, %rax                  # this is required as 
                    
    push %rbx                       # push rbx onto stack before function call
    call printf                     # call prinft
    pop %rbx                        # pop rbx off again

    ret
.data
format:
    .asciz "%ld\n"
