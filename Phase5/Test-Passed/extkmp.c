/*
拓展kmp
题意：
给出串a和串b，询问有多少个串c使得a是c的前缀而b是c的后缀。
用拓展kmp计算出最长公共前缀即可求解。 
题目链接：https://icpcarchive.ecs.baylor.edu/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=3887
样例输入：
3
xyzabcabc abcabcxyz
xyzabcd abcdxyz
acmicpc kualalumpur
样例输出：
3
2
1 
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char a[200],b[200],ch[500];
int n,m,len,f[200],t;
int min(int x,int y)
{
	if (x<y) return x;
	return y;
}
int max(int x,int y)
{
	if (x>y) return x;
	return y;
}
int get_val()
{
	int ret=0;
	char c;
	while((c=getchar())>='0' && c<='9')
  		ret=ret*10+c-'0';
 	return ret;
}
int main()
{
	int i,j,ans,cc;
//	freopen("input.txt","r",stdin);
//	freopen("output.txt","w",stdout);
	t=get_val();
	for (;t;t--) {
		ans=1;
		n=0,m=0;
		for (cc=getchar();cc<'a' || cc>'z';cc=getchar() ) ;
		a[++n]=cc;
		for (cc=getchar();'a'<=cc && cc<='z';cc=getchar() ) a[++n]=cc;
		for (;cc<'a' || cc>'z';cc=getchar() ) ;
		b[++m]=cc;
		for (cc=getchar();'a'<=cc && cc<='z';cc=getchar() ) b[++m]=cc;
		len=0;
		for (i=1;i<=m;i++) ch[++len]=b[i];
		ch[++len]='$';
		for (i=1;i<=n;i++) ch[++len]=a[i];
		f[1]=0,j=1;
		for (i=2;i<=len;i++) {
			if (j+f[j]>=i) f[i]=min(f[i-j+1],j+f[j]-i);else f[i]=0;
			f[i]=max(f[i],0);
			for (;(f[i]>=0) && (i+f[i]<=len) && (ch[1+f[i]]==ch[i+f[i]]);) f[i]++;
			f[i]--;
			if (i+f[i]>j+f[j]) j=i;
		}
		for (i=m+2;i<=len;i++)
			if (i+f[i]==len) ans++;
		printf("%d\n",ans);
	}
	return 0;
} 
