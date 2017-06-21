#include <stdio.h>

extern unsigned long int getT(unsigned long int);

void main ()
{

    unsigned long int t1, t2, result;

    // int Y = 100000;
    int Y = 10;
    int tab[100000];
    int tmp = 0;
    
    for (int i = 0; i < Y; i++) {
        t1 = getT(0);
        
        // printf("%s %lu \n", "Poczatkowo cykli: ", t1);
        tab[i] = tab[i];
	
        t2 = getT(1);
	// printf("%s %lu \n", "Koncowo cykli: ", t2);
        
	result = t2 - t1;
        if (result > 50) {
            printf("%d. %s %lu \n", i, "Licza wykonanych cykli: ", result);
        }
        
    }
    
    int length = 512;
    
    int matrix[512][512];
    int matrixT[512][512];
    int matrixResult[512][512];
    
    t1 = getT(0);
    for (int i = 0; i < length; i++) {
        for (int j = 0; j < length; j++) {
            matrixResult[i][j] += matrix[i][j] * matrix[j][i];
        }
    }
    t2 = getT(1);
    result = t2 - t1;
    printf("%s %lu \n", "Licza wykonanych cykli: ", result);

    for (int i = 0; i < length; i++) {
        for (int j = 0; j < length; j++) {
            matrixT[i][j] = matrix[j][i];
        }
    }
    
    t1 = getT(0);
    for (int i = 0; i < length; i++) {
        for (int j = 0; j < length; j++) {
            matrixResult[i][j] += matrix[i][j] * matrixT[i][j];
        }
    }
    t2 = getT(1);
    result = t2 - t1;
    printf("%s %lu \n", "Licza wykonanych cykli: ", result);
    
}

// 3121
// 2956
// 3121
