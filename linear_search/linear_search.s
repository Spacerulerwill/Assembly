# Build
# gcc linear_search.c linear_search.s -o linear_search -static
# Run
# ./linear_search

.text

.global  linear_search
linear_search:
    xor %rax, %rax              # rax is the current index counter
    jmp loop_check              # jump to first execution of the loop check
loop_body:                      
    cmp (%rdi), %rdx            # rsi stores the array pointer, compare value at pointer to element we are trying to locate
    je exit                     # if they match, branch to exit and return (index stored in rax)
    add $8, %rdi                # otherwise we go to next element (8 bytes along)
    inc %rax                    # increase current index
loop_check:
    cmp %rsi, %rax              # compare index and array length
    jl loop_body                # if less than, go back to loop body
exit:
    ret                         # return index (stored in rax)