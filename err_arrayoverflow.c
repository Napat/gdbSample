#include <stdio.h>
#include <stdint.h>

void arrayoverflow(){
	int32_t idx, array[5] = {1, 2, 3, 4, 5};
	for(idx=0; idx<=10; idx++){
		array[idx]++;
		printf("array[%d]=%d\r\n", idx, array[idx]);
	}	
}

int main(){
	arrayoverflow();
	printf("end main()\r\n");
	return 0;
}