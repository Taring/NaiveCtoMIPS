/*
�����Զ��� 
ural2040
���⣺��������ַ�ѯ�����ӵ��µĻ��Ĵ��ĸ�����
��ǰ��Ϊ�����Զ����ͺ�׺�Զ������񣬶�������ά������ʵ�ⶫ����ac�Զ�������һ�㡣
�����Զ����ı���Ҳ��ac�Զ�����࣬��ÿ�������Ӵ��ĺ�벿�ּӵ�trie����ȥ�������Ͱ��м�Ҳȡ��ȥ����
��failָ���ʾ��ǰ�ڵ����Ļ����Ӵ�������ĺ�׺��
���������Ѿ�������˴�s�Ļ����Զ��������������s+��c�������������ʶ����
����һ���ַ�֮����������һ�����Ĵ�������������Ĵ�����s+'c'������ĺ�׺��
����Ϊs'������б�Ļ����Ӵ����룬һ��Ҳ�����s����һ�����ĺ�׺��
��ô��s'�ĶԳ���Գ�һ�¾ͻᷢ����������Ӵ�һ����֮ǰ���ֹ��ˡ�
��ô����last��ʾ��ǰs��������Ӵ��ڻ����Զ����еĽڵ㣬������Լ�һ��last������ĳ��ȣ�
Ȼ��Ϳ����ж���������ϡ�c'�ǲ��ǻ��ǻ����Ӵ������ǵĻ�����failָ���ҵ�����ģ��ҵ�����Ľڵ�x֮��
�Ϳ���ͨ��next�ж��Ƿ��Ѿ�������������Ӵ���������ھͲ��ùܣ���������ھͿ�������һ���ڵ��ȥ��
ͬʱά��һ���µĵ��failָ�룬ά������ͬac�Զ������ƣ���ͣ��fail��ֱ������������
�ο������ʵ�֣��������������Ӵ���ż�������Ӵ�������һЩ������ά�����������ڵ�root-1��root0���ֱ��ʾ�����ĺ�ż������ʼ��
��root-1�Ķ��ӵ�failָ��root0��root0�Լ�ָ��root-1����Ϊ�����ַ���Ϊ���Ĵ��ģ���һ���ַ�֮����Ҫcheck�Ƿ���˫�ַ����Ĵ���
������������һ���ַ�֮���䱾����һ�����Ĵ��������Ҫȥroot-1��

��Ŀ���ӣ�http://acm.timus.ru/problem.aspx?space=1&num=2040 
�������룺
abbbba
���������
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
