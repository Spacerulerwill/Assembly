.text
.global majority_element
                                # array pointer is in rdi, size in rsi
majority_element:
    xor %rcx, %rcx              # rcx is the current index counter
    xor %rdx, %rdx              # rdx will store the count
    xor %rax, %rax              # rax will store candidate
    jmp loop_check              # jump to first execution of the loop check
loop_body:       
    test %rdx, %rdx             # is count 0?
    cmoveq (%rdi), %rax         # is count is zero, we move current number into candidate
    cmp (%rdi), %rax            # compare our current number and the candidate
    jne decrement               # not equal, decrement count
increment:                      # if equal, increment count
    inc %rdx
    jmp skip_decrement
decrement:
    dec %rdx
skip_decrement:
    add $8, %rdi                # otherwise we go to next element (8 bytes along)          
    inc %rcx                    # increase current index
loop_check:
    cmp %rsi, %rcx              # compare index and array length
    jl loop_body                # if less than, go back to loop body
exit:
    ret                         # return index (stored in rax)