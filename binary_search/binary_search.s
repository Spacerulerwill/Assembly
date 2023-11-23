.text

# rcx - low
# rax - mid
# rsi - array len
# rdi - array pointer
# rdx - elem to find

.global binary_search
binary_search:
    xor %rax, %rax                  # mid starts at 0
    xor %rcx, %rcx                  # low starst at 0
    mov %rsi, %r8                   # save the array length so we can return it if not found
    dec %rsi                        # high starts at array length minus one
    jmp loop_condition              # jump to loop condition to start while loop (while low <= high)
loop_body:               
    # calculate new mid (high + low // 2)
    mov %rcx, %rax                  # move low into %rax
    add %rsi, %rax                  # add high to %rax
    shr $1, %rax                    # divide by 2

    cmp %rdx,(%rdi,%rax,8)          # compare array[mid] with element
    jl less                         # if less than jump to less
    jg greater                      # if greater than jump to greater
    ret                             # if equal then return mid (%rax)
less:
    mov %rax, %rcx                  # mov mid into low
    inc %rcx                        # low++
    jmp loop_condition              # loop again
greater:
    mov %rax, %rsi                  # mov mid into high
    dec %rsi                        # high--
loop_condition:                         
    cmp %rsi, %rcx                  # compare low (rcx) and high (rsi)   
    jbe loop_body                   # if low <= high (%rcx <= %rsi) jump back to loop body 
    mov %r8, %rax
    ret                             # if we get here then the element has not been found, return value in %rax
