# Build:
# gcc game_of_life.s -o life -static -nostdlib
# Run:
# ./life

.data
.set rows, 10
.set columns, 20
.set total, (columns + 1) * rows 
buffer: .fill total, 1, 65
.set new_line, 10

.text
.global _start

_start:
    # first step is to add new lines to our char array array (last column of every row)
    mov $new_line, %al
    mov $buffer, %rbx
    dec %rbx

    xor %rcx,%rcx
    loop:  
        add $columns, %rbx
        inc %rbx
        mov %al, (%rbx)

        inc %rcx      
        cmp $rows, %rcx    
        jl loop   

    # print the grid
    mov $1, %rax
    mov $1, %rdi
    mov $buffer, %rsi
    mov $total, %rdx
    syscall
    ret

    # exit syscall
    mov $60, %rax                           # syscall code for exit
    xor %rdi, %rdi                          # return code is 0
    syscall   
