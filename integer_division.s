# very inefficient of way of performing unsigned integer divison
# by using repeated subtraction

# Build:
# gcc integer_division.s -o div -static
# Run:
# ./div


.text
.global main

.set dividend, 3                # number to be divided
.set divisor, 7                 # number to divide by

main:
    mov $dividend, %rax         # we store the dividend in rax
    xor %rcx, %rcx              # we store the qoutient in rcx - initially zero
                                # early exit - if divisor greater than dividend result will be 0 remainder dividend
    cmp $divisor, %rax          # if dividend less than divisor 
    jl finish                   # finish early
subtract:
    sub $divisor, %rax          # subtract divisor from rax    
    inc %rcx                    # increase quotient
    cmp $divisor, %rax          # compare rax and divisor
    jge subtract                # if rax is greater than divisor, subtract again
finish:
    mov $format, %rdi           # mov format string into rdi
    mov %rcx, %rsi              # mov quotient into rsi
    mov %rax, %rdx              # mov remainder into rdx
    xor %rax, %rax              # xor rax because of variadic args in printf

    push %rbx                   # push rbx because you have to when calling functions
    call printf                 # call prinft function
    pop %rbx                    # pop rbx off stack

    ret
.data
format:
    .asciz "%ld remainder %ld\n"
