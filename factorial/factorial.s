.text
.global factorial
factorial:
    mov %rdi, %rcx          # rcx will store the countdown
    dec %rcx                # rcx starts at number - 1 as rax will already to be set to number
    mov %rdi, %rax          # move number to rax to store current   
multiply:
    cmp $1, %rcx            # is counter at 1?
    je finish               # if it then we are done
                            # otherwise
    mul %rcx                # multiply rax by rcx and store in rax
    dec %rcx                # decrement rcx
    jmp multiply            # jump back to multiply
finish:
    ret
