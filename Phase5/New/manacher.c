/*
 * input:
 * aabbaaaaabbccdeaab
 *
 * output:
 * 56
 */

#include <stdio.h>

int getString(char *s) {
	int n = 0;
	for ( ; ; ) {
		int c = getchar();
		if (('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z')) {
			s[n++] = c;
			continue;
		}
		break;
	}
	s[n] = 0;
	return n;
}

int getMax(int a, int b) {
	if (a < b)
		return b;
	return a;
}

int getMin(int a, int b) {
	if (a < b)
		return a;
	return b;
}

// len[i] : the max length of palindrome whose mid point is (i / 2)
void Manacher(int n, char *cs, int *len) { // 0-based, len[] must be double sized
	int i, j, k;
	for (i = 0; i < n + n; ++i)
		len[i] = 0;
	for (i = 0, j = 0, k; i < n + n; i += k, j = getMax(j - k, 0)) {
		while (i - j >= 0 && i + j + 1 < n * 2 && cs[(i - j) / 2] == cs[(i + j + 1) / 2])
			j++;
		len[i] = j;
		for (k = 1; i - k >= 0 && j - k >= 0 && len[i - k] != j - k; k++)
			len[i + k] = getMin(len[i - k], j - k);
	}
}

char s[1025];
int len[1025];

int main() {
	int n = getString(s);
	int i, answer = 0;
	Manacher(n, s, len);
	for (i = 0; i < n + n; ++i)
		answer += len[i];
	printf("%d\n", answer);
	return 0;
}
