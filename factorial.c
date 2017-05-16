#include <stdio.h>
#include <stdint.h>

int32_t factorial(int32_t fact){
	if(fact == 0){
		return 1;
	} 
	return fact*factorial(fact-1);
}

int main()
{	int32_t fact;
	printf ("Enter factorial number: ");
	scanf ("%d", &fact );
	printf("factorial(%d) is %d\n", fact, factorial(fact));
}
