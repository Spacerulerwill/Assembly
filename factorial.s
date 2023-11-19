.text
.global main
    
# number to find factorial of
.set number, 13

main:
    mov $number, %rcx       # rcx will store the countdown
    dec %rcx                # rcx starts at number - 1 as rax will already to be set to number
    mov $number, %rax       # move number to rax to store current
multiply:
    cmp $1, %rcx            # is counter at 1?
    je finish               # if it then we are done
                            # otherwise
    mul %rcx                # multiply rax by rcx and store in rax
    dec %rcx                # decrement rcx
    jmp multiply            # jump back to multiply
finish:
                            # Push arguments for prinf
    mov $format, %rdi       # format string   
    mov %rax, %rsi          # number to format
    xor %rax, %rax          # zero rax becuase of variadic arguments 

    push %rbx               # push rbx because you have to apparently
    call printf             # prinft
    pop %rbx                # pop rbx back    

    ret
.data
format:
    .asciz "%ld\n"
