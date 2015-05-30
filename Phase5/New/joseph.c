#include <stdio.h>

//const int MaxN = 10005;
int a[1005];

int read() {
	char ch = getchar();
	int x;
	while ( ch < '0' || ch > '9')
		ch = getchar();
	for (x = 0; '0' <= ch && ch <= '9'; ch = getchar())
		x = 10 * x + ch - '0';
	return x;
}

int main() {
	
	int N, M, last;
	int i;
	//scanf("%d%d", &N, &M);
	N = read();
	M = read();
	for (i = 0; i < N; i ++) {
		a[i] = i + 1;
	}
	
	i = -1;
	//printf("---:%d\n", N);
	last = N;
	while (last > 0) {
		int j = 0;
		while (j < M) {
			i ++;
			if (i == N) i = 0;
			if (a[i] > 0) j ++;
		}
		printf("%d ", a[i]);
		a[i] = -1;
		last --;
	}
	printf("\n");
	return 0;
}