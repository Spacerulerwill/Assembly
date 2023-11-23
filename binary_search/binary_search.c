#include <stdio.h>
#include <inttypes.h>

uint64_t binary_search(int64_t* arr, int64_t size, int64_t elem);

int main() {
    int64_t arr[20] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20};
    printf("%lu\n", binary_search(arr, sizeof(arr)/sizeof(int64_t), 15));
    return 0;
}