# Build
# gcc linear_search.c linear_search.s -o linear_search -static
# Run
# ./linear_search

.text

.global  linear_search
linear_search:
    xor %rax, %rax
    jmp loop_check
loop_body:
    cmp (%rdi), %rdx
    je exit
    add $8, %rdi
    inc %rax
loop_check:
    cmp %rsi, %rax
    jl loop_body
exit:
    ret