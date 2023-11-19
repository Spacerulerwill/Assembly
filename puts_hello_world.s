.text
.global main
main:
    # call puts
    mov $message, %rdi
    call puts
    ret
.data
message:
    # null terminatinated hello world string
    .asciz "Hello, World!\n"
