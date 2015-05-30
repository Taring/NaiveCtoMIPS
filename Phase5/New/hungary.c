#include <stdio.h>
#include <stdlib.h>

struct Eglist {
	int other[10], succ[10], last[10], sum;
}e;

void addEdge(int a, int b) {
	e.other[e.sum] = b; e.succ[e.sum] = e.last[a]; e.last[a] = e.sum++;
	//e.other[e.sum] = a; e.succ[e.sum] = e.last[b]; e.last[b] = e.sum++;
}

int n, m, a, b;
int nxt[10], visit[10];

int dfs(int x) {
	int i, y;
	for (i = e.last[x]; ~i; i = e.succ[i]) {
		y = e.other[i];
		if (visit[y]) {
			continue;
		}
		visit[y] = 1;
        if (nxt[y] == -1 || dfs(y)) {
			nxt[y] = x;
			return 1;
		}
	}
	return 0;
}

int getInt() {
	char ch;
	int x = 0;
	ch = getchar();
	while (ch < '0' || ch > '9') {
		ch = getchar();
	}
	while (ch >= '0' && ch <= '9') {
		x = x * 10 + ch - '0';
		ch = getchar();
	}
	return x;
}

int main() {
	int i, j, answer = 0;
	n = getInt();
	m = getInt();
	e.sum = 0;
	for (i = 0; i < 10; i++) {

		e.last[i] = -1;
	}
	for (i = 1; i <= m; i++) {
		a = getInt();
		b = getInt();
		addEdge(a, b);
	}
	for (i = 1; i <= n; ++i) {
		nxt[i] = -1;
	}
	for (i = 1; i <= n; i++) {
		for (j = 1; j <= n; j++) {
			visit[j] = 0;
		}
		answer += dfs(i);
	}
	printf("%d\n", answer);
	return 0;
}