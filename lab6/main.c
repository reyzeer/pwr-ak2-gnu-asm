#include <stdio.h>

extern double integral_asm(double, double, double, int);
extern double integral_asm_k(double, double, double);

float f_c(float x)
{
    return x*x;
}

float integral_c(float start, float end, int parts)
{
    float summ = 0;
    float rectWidth = (end - start) / parts;
    float halfOfRectWidth = rectWidth / 2;
    for (int i = 1; i <= parts; i++) {
        float currentElement = rectWidth * i;
        summ += f_c(currentElement - halfOfRectWidth) * rectWidth;
    }
    
    return summ;
}

void main ()
{
    
    // float integralResult = integral_c(0.0, 2.0, 1);
    // printf("%f \n", integralResult);
    
    float k = integral_asm_k(1.0, 2.0, 3.0);
    printf("%f \n", k);
    
    float resultIntegralAsm = integral_asm(1.0, 2.0, 3.0, 3);
    printf("%f \n", resultIntegralAsm);

}
