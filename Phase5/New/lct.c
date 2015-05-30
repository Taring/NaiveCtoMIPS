//Link-cut-tree  HNOI2010 弹飞绵羊 正常数据！


int n,m;
int a[55];
int min(int x,int y)
{
    if (x<y) return x;
    return y;
}
struct node
{
	struct node *child[2],*fa,*path_p;
	int size;
} *p[110];
struct node *newNode()
{
    struct node *p;
    p=(struct node *)malloc(sizeof(struct node));
    p->child[0]=p->child[1]=p->fa=p->path_p=0;
    p->size=1;
    return p;
}
int f(struct node *p)
{
	return p==p->fa->child[1];
}
void push_up(struct node *p)
{
	p->size=1;
	if (p->child[0]) p->size+=p->child[0]->size;
	if (p->child[1]) p->size+=p->child[1]->size;
}
void rotate(struct node *p)
{
	struct node *fa=p->fa;
	int idx=f(p);
	p->fa=fa->fa;
	if (fa->fa) fa->fa->child[f(fa)]=p;
	fa->child[idx]=p->child[1^idx];
	if (p->child[1^idx]) p->child[1^idx]->fa=fa;
	p->child[1^idx]=fa;
	fa->fa=p;
	push_up(fa);
	p->path_p=fa->path_p;
}
void splay(struct node *p,struct node *root)
{
	struct node *fa;
	if (!p||!root||root==p) return;
	fa=root->fa;
	while (p->fa!=fa)
	{
		if (p->fa->fa==fa) rotate(p);
		else if (f(p)==f(p->fa))
		{
			rotate(p->fa);
			rotate(p);
		}
		else
		{
			rotate(p);
			rotate(p);
		}
	}
	push_up(p);
}
struct node *find_rt(struct node *p)
{
	while (p->fa) p=p->fa;
	return p;
}
void access(struct node *p)
{
	struct node *q=p;
	p=0;
	while (q)
	{
		splay(q,find_rt(q));
		if (q->child[1])
		{
			q->child[1]->fa=0;
			q->child[1]->path_p=q;
		}
		q->child[1]=p;
		if (p)
		{
			p->fa=q;
			p->path_p=0;
		}
		push_up(q);
		p=q;
		q=q->path_p;
	}
}
int data[50]={1,2,1,2,1,2,1,2,1,2};
int data2[50][3]={{1,1},{2,1,1},{1,1},{1,2},{2,5,1},{2,7,1},{2,8,1},{1,3},{1,4},{1,5},{1,6},{1,7},{1,8},{1,9},{1,10}};
int main()
{
	//freopen("data.in","r",stdin);
	//freopen("data.out","w",stdout);
	int i,x,t,y;
	n=10;
	for (i=1;i<=n+1;i++) p[i]=newNode();
	for (i=1;i<=n;i++)
	{
		x=data[i-1];
		p[i]->path_p=p[min(i+x,n+1)];
		access(p[i]);
	}
	m=14;
	for (i=1;i<=m;i++)
	{
		t=data2[i-1][0];
		x=data2[i-1][1];
		x++;
		if (t==1)
		{
			access(p[x]);
			splay(p[x],find_rt(p[x]));
			printf("%d\n",p[x]->child[0]->size);
		}
		else
		{
		    y=data2[i-1][2];
			access(p[x]);
			splay(p[x],find_rt(p[x]));
			p[x]->child[0]->fa=0;
			p[x]->child[0]->path_p=p[x]->path_p;
			p[x]->child[0]=0;
			p[x]->path_p=p[min(x+y,n+1)];
			access(p[x]);
		}
	}
	return 0;
}
