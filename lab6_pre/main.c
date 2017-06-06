#include <stdio.h>

extern int simd();

void main ()
{
        int result = simd();
        printf("%d \n", result);
}
