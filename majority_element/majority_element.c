#include <stdio.h>
#include <inttypes.h>

int64_t majority_element(int64_t* arr, size_t size);

int main() {
    int64_t arr[] = {3,3,3};
    printf("%lu\n", majority_element(arr, sizeof(arr) / sizeof(int64_t)));
    return 0;
}