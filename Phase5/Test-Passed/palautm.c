/*
回文自动机 
ural2040
题意：依次添加字符询问增加的新的回文串的个数。
以前以为回文自动机和后缀自动机很像，都是增量维护，其实这东西和ac自动机更像一点。
回文自动机的本质也和ac自动机差不多，把每个回文子串的后半部分加到trie树中去（奇数就把中间也取进去），
用fail指针表示当前节点代表的回文子串的最长回文后缀。
考虑现在已经处理好了串s的回文自动机，如何来处理s+‘c’，这里可以认识到，
加了一个字符之后至多增加一个回文串，而且这个回文串就是s+'c'的最长回文后缀，
假设为s'，如果有别的回文子串加入，一定也是这个s‘的一个回文后缀，
那么用s'的对称轴对称一下就会发现这个回文子串一定在之前出现过了。
那么就用last表示当前s的最长回文子串在回文自动机中的节点，这里可以记一下last这个串的长度，
然后就可以判断这个串添上’c'是不是还是回文子串，不是的话就沿fail指针找到满足的，找到满足的节点x之后，
就可以通过next判断是否已经存在这个回文子串，如果存在就不用管，如果不存在就可以新添一个节点进去，
同时维护一下新的点的fail指针，维护方法同ac自动机类似，不停找fail，直到满足条件。
参考培根的实现，对于奇数回文子串和偶数回文子串可以用一些技巧来维护，用两个节点root-1和root0来分别表示奇数的和偶数的起始，
将root-1的儿子的fail指向root0，root0自己指向root-1，因为单个字符作为回文串的，加一个字符之后需要check是否是双字符回文串，
而最终至少添一个字符之后其本身都是一个回文串因此最终要去root-1。

题目链接：http://acm.timus.ru/problem.aspx?space=1&num=2040 
样例输入：
abbbba
样例输出：
111111 
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char ch[500],ans[500];
int ss,rood,reven,last;
int next[500][2],rt[500],l[500];
void origin()
{
	int i,j;
    for (i=0;i<=ss;i++) {
        for (j=0;j<=1;j++) 
            next[i][j]=0;
        l[ss]=-2,rt[ss]=0;
    }
    ss=0;
    rood=++ss,l[rood]=-1,rt[rood]=rood;
    reven=++ss,l[reven]=0,rt[reven]=rood;
    last=rood;
}
int palin(int x,int id,int chr)
{
    return ch[id-1-l[x]]-'a'==chr;
}
void add(int chr,int id)
{
    for (;!palin(last,id,chr);last=rt[last]) ;
    if (next[last][chr]) last=next[last][chr];
    else {
        int x=last;
        ++ss;
        next[x][chr]=ss,l[ss]=l[x]+2;
        if (x==rood) rt[ss]=reven;
        else {
            x=rt[x];
            for (;x!=rood && (!next[x][chr] || !palin(x,id,chr));x=rt[x]) ;
            if (next[x][chr] && palin(x,id,chr)) rt[ss]=next[x][chr];
            else rt[ss]=rood;
        }
        last=ss;
    }
}
int main()
{
	//freopen("a.txt","r",stdin);
	int i,len=1;
    //gets(ch+1);
    ch[len]=getchar();
    while (ch[len] == 'a' || ch[len] == 'b') {
    	++len;
    	ch[len]=getchar();
    }
    ch[len]='\0';
    origin();
    //len=strlen(ch+1);
    len--;
    for (i=1;i<=len;i++) {
        int tmp=ss;
        add(ch[i]-'a',i);
        /*if (tmp!=ss) ans[i]='1';
        else ans[i]='0';*/
        if (tmp!=ss) printf("%c",'1');
        else printf("%c",'0');
    }
    ans[len+1]='\0';
    printf("\n");
//    puts(ans+1);
    return 0;
} 
