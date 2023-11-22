#include <stdio.h>
#include <inttypes.h>

uint64_t binary_search(int64_t* arr, int64_t size, int64_t elem);

int main() {
    int64_t arr[5] = {1,2,3,4,5};
    printf("%lu\n", binary_search(arr, sizeof(arr)/sizeof(int64_t), 3));
    return 0;
}