/*
 * input:
 * oiuasdnmyza
 *
 * output:
 * 10
 */

#include <stdio.h>

int getMax(int a, int b) {
	if (a < b)
		return b;
	return a;
}

int minimalRepresentation(int N, char *s) {
	// s must be double-sized and 0-based
	int i, j, k, l;
	for (i = 0; i < N; ++i)
		s[i + N] = s[i];
	s[N + N] = 0;
	for (i = 0, j = 1; j < N; ) {
		for (k = 0; k < N && s[i + k] == s[j + k]; ++k);
		if (k >= N)
			break;
		if (s[i + k] < s[j + k])
			j += k + 1;
		else {
			l = i + k;
			i = j;
			j = getMax(l, j) + 1;
		}
	}
	return i; // [i, i + N) is the minimal representation
}

int getString(char *s) {
	int n = 0, c;
	for ( ; ; ) {
		c = getchar();
		if (('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z')) {
			s[n++] = c;
			continue;
		}
		break;
	}
	s[n] = 0;
	return n;
}

char s[1025];

int main() {
	int n = getString(s);
	printf("%d\n", minimalRepresentation(n, s));
	return 0;
}
