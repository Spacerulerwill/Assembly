# very inefficient of way of performing unsigned integer divison
# by using repeated subtraction

.text
.global main

.set dividend, 3               # number to be divided
.set divisor, 7                 # number to divide by

main:
    mov $dividend, %rax         # we store the dividend in rax
    xor %rcx, %rcx              # we store the qoutient in rcx
subtract:
    cmp $divisor, %rax          # is rax less than the divisor?
    jl finish                   # if yes, rax is the remainder and goto finish
    sub $divisor, %rax          # otherwise subtract divisor from dividend
    inc %rcx                    # increase rcx as a subtraction has taken place
    jmp subtract                # go back to subtract
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
