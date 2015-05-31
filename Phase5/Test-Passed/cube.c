#include<stdio.h>
#include<string.h>
int perm[3][6] = {
	{5, 4, 2, 3, 0, 1},
	{3, 2, 0, 1, 4, 5},
	{0, 1, 4, 5, 3, 2}
};

int n;
int a[1111][6];
 
void transform(int a[6], int k) {
	int b[6], j, i;
	for (j = 0; j < 6; ++j) {
		b[j] = a[j];	
	}
	for (i = 0; i < 6; ++i) {
		a[perm[k][i]] = b[i];	
	}
}

int getInt() {
	char c = getchar();
	int res = 0;
	while(c < '0' || c > '9') {
		c = getchar();
	}
	while(c >= '0' && c <= '9') {
		res = res * 10 + c - '0';
		c = getchar();
	}
	return res;
}

int main() {
	int i, j, ret, t0, t1, t2, b[6], same, ok;
	n = getInt();
	for(i = 0; i < n; ++i) {
		for(j = 0; j < 6; ++j) {
			a[i][j] = getInt();	
		}	
	}
	
	ret = 0;
	for (i = 1; i < n; ++i) {
		ok = 0;
		for (t0 = 0; t0 < 4; ++t0) {
			for (t1 = 0; t1 < 4; ++t1) {
				for (t2 = 0; t2 < 4; ++t2) {
					for (j = 0; j < 6; ++j) {
						b[j] = a[i][j];	
					}
					for (j = 0; j < t0; ++j) {
						transform(b, 0);
					}
					for (j = 0; j < t1; ++j) {
						transform(b, 1);
					}
					for (j = 0; j < t2; ++j) {
						transform(b, 2);
					}
					same = 1;
					for (j = 0; j < 6; ++j) {
						if (b[j] != a[0][j]) {
							same = 0;
							break;
						}
					}
					if (same) {
						ok = 1;
					}
				}	
			}	
		}
		ret += ok;
	}
	printf("%d\n", ret);
	return 0;
}

