# -nostdlib
.global _start

_start:
    # write syscall
    mov $1, %rax                # syscall code for write
    mov $1, %rdi                # file descriptor for write (1 - stdout)
    mov $hello_world, %rsi      # load effective address of null termianted string into register
    mov $14, %rdx               # load string length
    syscall
    
    # exit syscall
    mov $60, %rax                # syscall code for exit
    xor %rdi, %rdi              # return code is 0
    syscall

hello_world:
    # null terminated hello world string
    .asciz "Hello, World!\n"
