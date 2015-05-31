#include<stdio.h>
#include<string.h>
int perm[3][6] = {
	{5, 4, 2, 3, 0, 1},
	{3, 2, 0, 1, 4, 5},
	{0, 1, 4, 5, 3, 2}
};

int main() {

//	int a[3][6];
	int i, j;
	for (i = 0; i < 3; ++i) {
		for (j = 0; j < 6; ++j)
			printf("%d ", perm[i][j]);
		printf("\n");
	}
			//a[i][j] = perm[i][j];

	return 0;
}

