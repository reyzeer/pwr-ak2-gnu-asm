#include <stdio.h>

extern unsigned long int getT(unsigned long int);

void main ()
{
	
	unsigned long int t1, t2, result;
	
	t1 = getT(0);
	t2 = getT(1);

	result = t2 - t1;
	printf("%s %lu \n", "Licza wykonanych cykli: ", result);
}
