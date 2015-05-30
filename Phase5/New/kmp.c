#include <stdio.h>

int main() {
	char s2[11]="abcabcfeabc";
	char s1[2] = "ab";
    int i,j,len1,len2;
    int ans, pre[12];
    ans = 0;
    pre[0]=-1;
	j=-1;
    len1 = 2;
    len2 = 11;
    for (i=1;i<len1;i++) {
        while (j!=-1&&s1[j+1]!=s1[i]) j=pre[j];
        if (s1[j+1]==s1[i]) j++;
        pre[i]=j;
    }
    j=-1;
    for (i=0;i<len2;i++) {
        while (j!=-1&&s1[j+1]!=s2[i]) j=pre[j];
        if (s1[j+1]==s2[i]) j++;
        if (j==len1-1) {
        	ans++;
			j=pre[j];
        }
	}
    printf("%d\n",ans);
    return 0;
}
//3
