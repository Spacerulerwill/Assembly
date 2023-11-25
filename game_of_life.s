# Build:
# gcc game_of_life.s -o life -static -nostdlib
# Run:
# ./life

.data
.set rows, 10
.set columns, 20
.set total, (columns + 1) * rows
.set live, 111
.set dead, 32
.set new_line, 10
framebuffer1: .fill total, 1, live
framebuffer2: .fill total, 1, live

.text
.global _start

_start:
    # setup 2 framebuffers by replacing last byte of each row to a newline
    mov $framebuffer1, %r12
    dec %r12
    mov $framebuffer2, %r13                                        
    dec %r13

    mov $new_line, %al                                                      
    xor %rcx,%rcx
    loop:
        add $columns, %r12
        inc %r12
        mov %al, (%r12)

        add $columns, %r13
        inc %r13
        mov %al, (%r13)

        inc %rcx
        cmp $rows, %rcx   
        jl loop

    mov $framebuffer1, %r12
    mov $framebuffer2, %r13

    mainloop:
        # make a copy of our framebuffer in r12 and store in r13
        xor %rcx,%rcx
        loop2:
            mov (%r12), %al
            mov %al, (%r13)

            inc %r12
            inc %r13
            inc %rcx
            cmp $total, %rcx
            jl loop2

        sub $total, %r12
        sub $total, %r13

        # print framebuffer in r12
        mov $1, %rax
        mov $1, %rdi
        mov %r12, %rsi                                                                                                     
        mov $total, %rdx
        syscall

        # do cellular automata, reading from r13 and storing result in r12
        xor %rcx,%rcx
        cell_loop:      
            mov $new_line, %al
            cmp %al, (%r13)
            je next

            mov $live, %al
            cmp %al, (%r13)
            je set_dead

            set_living:
                mov %al, (%r12)
                jmp next
            set_dead:
                mov $dead, %al
                mov %al, (%r12)
        next:  
            inc %r12
            inc %r13                                  
            inc %rcx    
            cmp $total, %rcx
            jl cell_loop
        
        sub $total, %r12
        sub $total, %r13

        # wait 1 second
        push $0
        push $1

        mov   %rsp, %rdi
        mov   $35, %rax
        xor   %rsi, %rsi
        syscall

        add $16, %rsp

        # loop again
        jmp mainloop
