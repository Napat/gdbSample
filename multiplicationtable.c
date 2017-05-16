#include <stdio.h>
#include <stdint.h>

void mutiplicationtable(int32_t num){
	int32_t round, out=1;
	for (round=1; round<=12; round++){
		out=out*round;
		printf("%d x %d = %d\r\n", num, round, num*round);
	}
}

int main(int argc, char **argv)
{	int32_t num;
	if( argc != 2 ){
		printf("Try:\r\n %s 5\r\n", argv[0]);
		return -1;
	}
	num = atoi(argv[1]);
	mutiplicationtable(num);
}

