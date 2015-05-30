#include<stdio.h>
int F(int x, int tb) {
	if(x % 3 == 1) {
		return x / 3;
	}else {
		return x / 3 + tb;
	}
}
int G(int x, int tb) {
	if(x < tb) {
		return x * 3 + 1;
	}else {
		return (x - tb) * 3 + 2;
	}
}
int max(int x, int y) {
	if(x > y) {
		return x;
	}else {
		return y;
	}
}
int wa[10000],wb[10000],wv[10000],wss[10000];
int s[10000*3],sa[10000*3];
int c0(int *r,int a,int b)
{
	return r[a]==r[b]&&r[a+1]==r[b+1]&&r[a+2]==r[b+2];
}
int c12(int k,int *r,int a,int b)
{
	if(k==2) return r[a]<r[b]||r[a]==r[b]&&c12(1,r,a+1,b+1);
	else return r[a]<r[b]||r[a]==r[b]&&wv[a+1]<wv[b+1];
}
void sort(int *r,int *a,int *b,int n,int m)
{
	int i;
	for(i=0;i<n;i++) wv[i]=r[a[i]];
	for(i=0;i<m;i++) wss[i]=0;
	for(i=0;i<n;i++) wss[wv[i]]++;
	for(i=1;i<m;i++) wss[i]+=wss[i-1];
	for(i=n-1;i>=0;i--) b[--wss[wv[i]]]=a[i];
}
void dc3(int *r,int *sa,int n,int m)
{
	int i,j,*rn=r+n,*san=sa+n,ta=0,tb=(n+1)/3,tbc=0,p;
	r[n]=r[n+1]=0;
	for(i=0;i<n;i++)
		if(i%3!=0) wa[tbc++]=i;
	sort(r+2,wa,wb,tbc,m);
	sort(r+1,wb,wa,tbc,m);
	sort(r,wa,wb,tbc,m);
	for(p=1,rn[F(wb[0], tb)]=0,i=1;i<tbc;i++)
		if(c0(r, wb[i - 1], wb[i])) {
			rn[F(wb[i], tb)]=p-1;
		}else {
			rn[F(wb[i], tb)] = p++;
		}
	if (p<tbc) dc3(rn,san,tbc,p);
	else for (i=0;i<tbc;i++) san[rn[i]]=i;
	for (i=0;i<tbc;i++)
		if(san[i]<tb) wb[ta++]=san[i]*3;
	if(n%3==1) wb[ta++]=n-1;
	sort(r,wb,wa,ta,m);
	for(i=0;i<tbc;i++)
		wv[wb[i]=G(san[i], tb)]=i;
	for(i=0,j=0,p=0;i<ta && j<tbc;p++)
		if(c12(wb[j]%3,r,wa[i],wb[j])) {
			sa[p]=wa[i++];
		}else {
			sa[p] = wb[j++];
		}
	for(;i<ta;p++) sa[p]=wa[i++];
	for(;j<tbc;p++) sa[p]=wb[j++];
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

int main(){
	int n,m=0, i;
	n = getInt();
	for (i=0;i<n;i++) s[i] = getInt(),s[i]++,m=max(s[i]+1,m);
	s[n++]=0;
	dc3(s,sa,n,m);
	for (i=0;i<n;i++) printf("%d ",sa[i]);printf("\n");
}
