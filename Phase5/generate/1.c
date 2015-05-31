#include <stdio.h>
#include <stdlib.h>

int getcount(int* count) {
	return ++(*count);
}
int main() {
	int* count;
	int v0;

	count = malloc(sizeof(int));
	*count = 0;
	v0 = getcount(count);

	printf("%d ",v0);
	printf("\n");
	printf("%d ",v0);
	printf("\n");
	return 0;
}
