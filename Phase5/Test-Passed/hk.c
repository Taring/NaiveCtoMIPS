#include<stdio.h>

int read(){
	int x = 0;
	char c = getchar();
	for(; c < '0' || '9' < c; c = getchar());
	for(;'0' <= c && c <= '9'; c = getchar())
		x = 10 * x + c - '0';
	return x;
}

//const int N = 205, M = 205;
int n, m, ans = 0;

struct node {
	int u,v;
} a[205];

int visit[205], first[205], edge[2 * 205], next[2 * 205];
int num = 0;
void edge_add(int u, int v) {
	edge[++num] = v;
	next[num] = first[u];
	first[u] = num;
}

int match[205], opt[205];
int dx[205], dy[205], queue[205];
int search() {
	int head = 1, tail = 0;
	int flag = 0, i,u,v,k;
	for (i = 1; i <= n; ++i)
		dx[i] = dy[i] = 0;
	for (i = 1; i <= n; ++i)
		if(!opt[i])
			queue[++tail] = i, dx[i] = 1;
	for(; head <= tail; ++head) {
		u = queue[head];
		for (k = first[u]; k; k = next[k]){
			v = edge[k];
			if (dy[v])
				continue;
			dy[v] = dx[u] + 1;
			if(!match[v])
					flag = 1;
				else 
					dx[queue[++tail] = match[v]] = dy[v] + 1;
		}
	}
	return flag;
}

int Extend_Path(int u) {
	int v, k, t;
	for ( k = first[u]; k; k = next[k]){
		v = edge[k];
		if (dy[v] != dx[u] + 1)
			continue;
		dy[v] = 0;
		t = match[v];
		match[v] = u; opt[u] = v; opt[t] = 0;
		if(!t || Extend_Path(t))
			return 1;
		opt[u] = 0; match[v] = t; opt[t] = v;
	}
	return 0;
}

void Hopcroft_Karp() {
	int i;
	while (search())
		for (i = 1; i <= n; ++i)
			if (!opt[i] && Extend_Path(i))
				++ans;
}

int main() {
	//freopen("clo.in","r",stdin);
	//freopen("clo.out","w",stdout);
	int i;
	n = read();
	m = read();
	for (i = 1; i <= m; ++i) {
		a[i].u = read();
		a[i].v = read();
		edge_add(a[i].u, a[i].v);
	}

	Hopcroft_Karp();

	printf("%d\n", ans);
}
