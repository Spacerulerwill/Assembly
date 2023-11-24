.text

# register usage
# rax - stores current mid
# rcx - stores the low value
# rsi - stores the high value
# r8  - used to save array length. Not sure if I should use stack or this extra register to save it.
# rdi - array pointer

.global binary_search
binary_search:
    xor %rax, %rax                  # mid starts at 0
    xor %rcx, %rcx                  # low starst at 0
    mov %rsi, %r8                   # save the array length so we can return it if not element not found
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
                                    # if we get to here the element was not present in the array
    mov %r8, %rax                   # copy the array length into rax (length of array is an impossible index)
    ret                             # return
