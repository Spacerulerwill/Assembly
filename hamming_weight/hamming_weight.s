.text
.global hamming_weight
hamming_weight:
    xor %rax, %rax                  # store number of one bits in rax
    jmp loop_condition              # go to condition check of while loop
loop_content:                       # loop body
    mov %rdi, %rcx                  # mov rcx into rcx
    and $1, %rcx                    # bitwise and of 1 to check if it has trailing 1 bit
    add %rcx, %rax                  # add the result of this to rax
    shr $1, %rdi                    # shift once to the right
loop_condition:                     # condition for while loop
    cmp $0, %rdi                    # is rcx and 0
    jne loop_content                # if rcx not equal to zero, loop again
    ret
