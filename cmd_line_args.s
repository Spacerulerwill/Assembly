# Build:
# gcc cmd_line_args.s -o args -static
# Run:
# ./args (any amount of command line arguments)

.text
.global main

main:
    push    %rdi                    # rdi and rsi are volatile registers so must be pushed to stack before puts call
    push    %rsi
    sub     $8, %rsp                # stack must be aligned to 16 byte boundary before call (return address is also 8 bytes)

    mov     (%rsi), %rdi            # the argument pointer to string to display
    call    puts                    # print it

    add     $8, %rsp                # restore %rsp to pre-aligned value
    pop     %rsi                    # pop registers back off stack to restore
    pop     %rdi

    add     $8, %rsi                # point to next argumentl 8 bytes along
    dec     %rdi                    # count down
    jnz     main                    # if not done counting keep on printing!

    ret
format:
    .asciz  "%s\n"