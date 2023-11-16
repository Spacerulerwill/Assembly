.global main
    
.text
main:
    # call puts
    mov $message, %rdi
    call puts
    ret
message:
    # null terminatinated hello world string
    .asciz "Hello, World!\n"
