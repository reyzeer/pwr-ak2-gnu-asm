#include <stdio.h>

extern unsigned long int getT(unsigned long int);

void main ()
{
	
	unsigned long int t1, t2, result;
	
	t1 = getT(0);
	printf("%s %lu \n", "Poczatkowo cykli: ", t1);
	
	int x = 0;
	for (int i = 0; i < 1000000; i++) {
		x += i;	
	}
	printf("%d: \n", x);

	t2 = getT(1);
	printf("%s %lu \n", "Koncowo cykli: ", t2);

	result = t2 - t1;
	printf("%s %lu \n", "Licza wykonanych cykli: ", result);
}
