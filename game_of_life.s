# Build:
# gcc game_of_life.s -o life -static -nostdlib
# Run:
# ./life

.data
.set rows, 10
.set columns, 20
.set total, columns * rows
buffer: .fill total, 1, 65
new_line: .ascii "\n"
erase: .ascii "\033[2J"

.text
.global _start

_start:
    call print_grid

    # exit syscall
    mov $60, %rax                           # syscall code for exit
    xor %rdi, %rdi                          # return code is 0
    syscall

print_grid:
    mov $buffer, %rbx                       # move buffer pointer to rbx
    xor %rcx,%rcx                           # loop counter in rcx

    loop:                                   # loop body
        push %rcx                           # preserve value of rcx and syscalls will clobber its value

        # write line
        mov $1, %rax                        
        mov $1, %rdi
        mov %rbx, %rsi
        mov $columns, %rdx
        syscall
        
        # write newline char
        mov $1, %rax
        mov $1, %rdi
        mov $new_line, %rsi
        mov $1, %rdx
        syscall

        pop %rcx                            # restore rcx's value

        inc %rcx                            # increment rcx
        add $columns, %rbx                  # move buffer pointer along by $columns
        cmp $rows, %rcx                     # compare number of rows and loop counter
        jl loop                             # if less, loop again
    ret
