# Build:
# gcc fibonacci.s -o fib -static
# Run:
# ./fib


.text
.global main

main:
    push %rbx                    # we have to save this since we use it

    mov $93, %cl                # cl (1 byte) will store countdown to zero
    xor %rax, %rax              # zero rax to store current number
    xor %rbx, %rbx              # zero rbx to store next number
    inc %rbx                    # rbx starts at 1
print:
    # Call prinf, this may destroy rax and cl as they are volatile registers
    # So we push them to the stack
    push %rax                 
    push %rcx 
    
    # Push arguments for prinf
    mov $format, %rdi           # format parameter
    mov %rax, %rsi              # current number
    xor %rax, %rax              # magic number required as prinft has variadic arguments

    # The stack will already be aligned when we make the call
    # as we used 3 8 byte arguments and the return address is 8 bytes
    # so it is properly aligned to a 16 byte boundary
    call printf                 

    # Pop rax and rcx off stack again
    pop %rcx
    pop %rax

    mov %rax, %rdx              # Save the current number into rdx
    mov %rbx, %rax              # Current number is now the old next number
    add %rdx, %rbx              # The new next number is the old current number + old next number
    dec %cl                    # Count down
    jnz print                   # If not done counting, do some more

    # Pop rbx off stack and return!
    pop %rbx 
    ret
.data
format:
    .asciz "%ld\n"
