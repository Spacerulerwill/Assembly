# Build:
# gcc game_of_life.s -o life -static -nostdlib
# Run:
# ./life

.data
.set rows, 10                                                               # rows in the grid
.set columns, 20                                                            # columns in the grid
.set total, (columns + 1) * rows                                            # total bytes for byte array. 1 byte extra needed per row for \n
.set live, 111
.set dead, 32
buffer: .fill total, 1, live                                                 # byte array filled with o
.set new_line, 10                                                           # ascii code of newline char

.text
.global _start

_start:
                                                                            # replace char at end of every row with newline
    mov $new_line, %al                                                      
    mov $buffer, %rbx                                                   
    dec %rbx

    xor %rcx,%rcx                                                           # loop counter
    loop:                                                                   # loop body
        add $columns, %rbx                                                  # move along $columns elements in byte array
        inc %rbx                                                            # move one more for newline
        mov %al, (%rbx)                                                     # move newline char into array

        inc %rcx                                                            # increase counter
        cmp $rows, %rcx                                                     # compare counter and number of rows    
        jl loop                                                             # if counter < rows, loop again

    mainloop:                                                               # main game loop
                                                                            # print the grid    
        mov $1, %rax                                                        # sys_write syscall id
        mov $1, %rdi                                                        # first argument - field descriptor: 1 - stdout
        mov $buffer, %rsi                                                   # second argument - pointer to char array                                                                                                        
        mov $total, %rdx                                                    # third argument - length of char array
        syscall                                                             # invoke syscall

                                                                            # iterate over every cell in our byte buffer and create the next generation
        mov $buffer, %rbx                                                   # set %rbx to start of char buffer
        xor %rcx,%rcx                                                       # set counter to 0
        cell_loop:   
                                                                            # if the cell is a newline, skip this iteration
            mov $new_line, %al                                             # move new_line into rax
            cmp %al, (%rbx)                                                # compare rax and value being pointed to in the array in %rbx
            je next                                                         # if its a newline we can skip to the next loop

            # simple flip if alive
            mov $live, %al
            cmp %al, (%rbx)
            je set_dead

            set_living:
                mov %al, (%rbx)
                jmp next
            set_dead:
                mov $dead, %al
                mov %al, (%rbx)
        next:                                   
            inc %rcx                                                        # increase counter
            inc %rbx                                                        # go to next char
            cmp $total, %rcx                                                # cmp total and counter
            jl cell_loop                                                    # if less, loop again

                                                                            # push arguments onto stack for sys_nanosleep call
        push $0                                                             # nanoseconds
        push $1                                                             # seconds

        mov   %rsp, %rdi                                                    # the time structure we just pushed
        mov   $35, %rax                                                     # SYS_nanosleep syscall id
        xor   %esi, %esi                                                    # rem=NULL, we don't care if we wake early
        syscall                                                             # invoke syscall

        jmp mainloop                                                        # loop again!
