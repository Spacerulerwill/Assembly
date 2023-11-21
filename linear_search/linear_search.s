# Build
# gcc call_linear_search.c linear_search.s -o linear_search -static
# Run
# ./linear_search

.text

.global  linear_search
linear_search:
    mov $5, %rax
    ret