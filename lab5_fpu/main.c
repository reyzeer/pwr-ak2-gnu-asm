#include <stdio.h>

extern double f(double);
extern double g(double);

void main ()
{
        double result = f(-10.0);
        printf("%f \n", result);
        result = g(200.0);
        printf("%f \n", result);
}
