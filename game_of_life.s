# Build:
# gcc game_of_life.s -o life -static -nostdlib
# Run:
# ./life

.data
.set rows, 10
.set columns, 20
.set total, (columns + 1) * rows # we need one extra column for newline characters 
buffer: .fill total, 1, 111
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

    mainloop:
        # print the grid
        mov $1, %rax
        mov $1, %rdi
        mov $buffer, %rsi
        mov $total, %rdx
        syscall

        # sleep for time before reprinting
        pushq $0    # nanoseconds
        pushq $1    # seconds

        mov   %rsp, %rdi    # the time structure we just pushed
        mov   $35, %rax     # SYS_nanosleep
        xor   %esi, %esi    # rem=NULL, we don't care if we wake early
        syscall
        
        jmp mainloop
