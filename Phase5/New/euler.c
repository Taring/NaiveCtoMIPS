#include<string.h>
#include<stdio.h>

struct node
{
       int d,w;
       struct node *next;
}*lin[50];
int top=0;
int used[2000];
int sum[50],path[2000];
int n,m;
int init()
{
    int ans=0;
    ans=getchar()-'0';
    getchar();
    return ans;
}
void clear()
{
     int i;
     for(i=0;i<=50;i++)lin[i]=0; 
     top=0;
}
void ins(int a,int b,int w)
{
     struct node *p = malloc(sizeof(struct node));
     p->d=b;
     p->next=lin[a];
     p->w=w;
     lin[a]=p;
}
void dfs(int x)
{
     struct node *p=lin[x];
     while(p!=0)
     {
                   if(!used[p->w])
                   {
                         used[p->w]=1;
                         dfs(p->d);
                         path[++top]=p->w;
                   }
                   p=p->next;
     }
}
int main()
{
             
            //   freopen("1041.in","r",stdin);
            //   freopen("1041.out","w",stdout);
               int i,j;int flag=1;
               n=init();m=init();
               for(i=1;i<=m;i++)
               {
                          int x,y,w;
                          x=init();y=init();w=init();
                          ins(x,y,w);
                          ins(y,x,w);
                          sum[x]++;sum[y]++;
               }
               for(i=1;i<=50;i++)
               if(sum[i]%2==1)
               {
                             // cout<<"Round trip does not exist."<<endl;
                              flag=0;
                              break;
               }
            //   if(flag)
            //   {
                       used[0]=1;
                       dfs(1);
                       for(j=top;j>1;j--)printf("%d ",path[j]);
                       printf("%d\n",path[1]);
           //    }

    return 0;
}
