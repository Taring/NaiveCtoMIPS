// This is a program which executes the algorithm to find
// dominate tree and dominate frontier by iteration. The
// algorithm is one of the core algorithms in building SSA.
// I wrote it to affirm the correction of my implementation
// of the pseudo-code described in the paper. It seems to be
// right.

#include <stdio.h>
#include <stdlib.h>
#define N 100000

int n, m, top, *dom, source, *pre, *stack, *order;

struct Node {
	int v;
	struct Node *nxt;
}**g, **imm, **fron;

void dfs(int x) {
//test of recursion
	struct Node *iter = g[x];
	while (iter) {
		struct Node *tmp = (struct Node *) malloc(sizeof (struct Node));
		if (pre[iter->v] == -1) {
			pre[iter->v] = x;
			dfs(iter->v);
		}
		tmp->v = x;
		tmp->nxt = imm[iter->v];
		imm[iter->v] = tmp;
		iter = iter->nxt;
	}
	stack[n - ++top] = x;
	order[x] = top;
}

int get_dom(int x, int y) {
//test of loop
	while (x != y) {
		if (order[x] < order[y]) {
			x = dom[x];
		} else {
			y = dom[y];
		}
	}
	return x;
}

int get_int() {
//test of input
//I write a int reader due to the fact that we only have getchar
	char ch = getchar();
	int res = 0;
	while ((ch < '0' || ch > '9') && ch != '-') {
		ch = getchar();
	}
	if (ch == '-') {
		return -get_int();
	}
	while (ch >= '0' && ch <= '9') {
		res = res * 10 + ch - '0';
		ch = getchar();
	}
	return res;
}

int main() {
	int flag = 1, i;
	n = get_int();
	m = get_int();
//test of cast expression
	dom = (int *) malloc(n * sizeof (int));
	pre = (int *) malloc(n * sizeof (int));
	stack = (int *) malloc(n * sizeof (int));
	order = (int *) malloc(n * sizeof (int));
	g = (struct Node **) malloc(n * sizeof (struct Node *));
	imm = (struct Node **) malloc(n * sizeof (struct Node *));
	fron = (struct Node **) malloc(n * sizeof (struct Node *));
	for (i = 0; i < n; ++i) {
		pre[i] = dom[i] = -1;
		imm[i] = g[i] = 0;
	}
	for (i = 0; i < m; ++i) {
		int u = get_int();
		int v = get_int();
		struct Node *tmp = (struct Node *) malloc(sizeof (struct Node));
		tmp->v = v;
		tmp->nxt = g[u];
		g[u] = tmp;
	}
	source = get_int();
	dom[source] = pre[source] = source;
	dfs(source);
// the body of iteration
	while (flag) {
		int new_dom;
		flag = 0;
		for (i = 1; i < n; ++i) {
			struct Node *iter = imm[stack[i]];
			new_dom = pre[stack[i]];
			while (iter) {
				if (dom[iter->v] != -1) {
					new_dom = get_dom(new_dom, iter->v);
				}
				iter = iter->nxt;
			}
			if (new_dom != dom[stack[i]]) {
				dom[stack[i]] = new_dom;
				flag = 1;
			}
		}
	}
	for (i = 0; i < n; ++i) {
		int cnt = 0;
		struct Node *iter = imm[i];
		while (iter) {
			++cnt;
			iter = iter->nxt;
		}
		if (cnt >= 2) {
			iter = imm[i];
			while (iter) {
				int runner = iter->v;
				while (runner != dom[i]) {
					struct Node *tmp = (struct Node *) malloc(sizeof (struct Node));
					tmp->v = i;
					tmp->nxt = fron[runner];
					fron[runner] = tmp;
					runner = dom[runner];
				}
				iter = iter->nxt;
			}
		}
	}
	//output dom
	for (i = 0; i < n; ++i) {
		printf("%d %d\n", i, dom[i]);
	}
	//output dom fron
	for (i = 0; i < n; ++i) {
		struct Node *iter = fron[i];
		printf("%d:", i);
		while (iter) {
			printf(" %d", iter->v);
			iter = iter->nxt;
		}
		printf("\n");
	}
	return 0;
}
