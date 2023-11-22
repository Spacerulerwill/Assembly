#include <stdio.h>
#include <inttypes.h>

uint64_t hamming_weight(uint64_t num);

int main() {
    printf("%lu\n", hamming_weight(41));
    return 0;
}