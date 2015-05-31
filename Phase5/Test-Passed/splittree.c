/*
这是Online Judge 1358.分割树 的程序（把数组改小了）。
主要测试struct
Sample Input:
10
1 2
2 3
3 4
4 5
6 7
7 8
8 9
9 10
3 8

Sample Outut：
3
8
*/

#include <stdio.h>

int N;
int x, y;
struct node
{
	int num;
	int parent;
	int sub, cnt;
        int allink[15];
};
 
struct node tree[105];
int flag;
int init[105];
int num_of_p;
int num_of_sub(int p)
{
	int i;
	for(i = 0;i < tree[p].cnt; ++i)
	{
		if(tree[p].allink[i] == tree[p].parent) continue;
		tree[tree[p].allink[i]].parent = tree[p].num;
		tree[tree[p].allink[i]].sub -= 1;
		tree[p].sub += num_of_sub(tree[p].allink[i]) - 1;
	}
	return tree[p].sub;
}
 
struct node  alloc_node(int x){
	struct node  temp;
	temp.sub = 1;
        temp.parent = 0;
        temp.num = x;
        temp.cnt = 0;
	return temp;
}

int is_digit(char c)
 {
  return c >='0' && c <= '9';
 }

int get_d()
{
 char c =getchar();
 int t = 0;
 while (!is_digit(c)) c = getchar();
 while (is_digit(c))
 {
  t=t*10+c-48;c=getchar();
 }
 return t;
}

int main()
{
        int i;
	N=get_d();
	for(i = 0; i < N-1; ++i)
	{
                x = get_d();y = get_d();
		if(!init[x]) tree[x] = alloc_node(x);
		if(!init[y]) tree[y] = alloc_node(y);
                tree[x].allink[tree[x].cnt] = y;
		tree[x].cnt++;
		tree[x].sub++;
		tree[y].allink[tree[y].cnt]=x;
		tree[y].cnt++;
		tree[y].sub++;
                init[x] = init[y] = 1;
	}
 
	num_of_sub(1);
	for(i = 1; i <= N; ++i)
	{
		struct node now = tree[i];
                int j;
		flag = 1;
		num_of_p = 0;
		for(j = 0; j < now.cnt; ++j)
		{
			if(now.allink[j] == now.parent)
			   continue;
			if(tree[now.allink[j]].sub > N / 2)
			{
				flag = 0;
				break;
			}
			num_of_p += tree[now.allink[j]].sub;
		}
		num_of_p = N - 1 - num_of_p;
		if(num_of_p > N / 2) flag = 0;
		if(flag) printf("%d\n", i);
	}
}
