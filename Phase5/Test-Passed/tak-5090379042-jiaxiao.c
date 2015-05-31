/*
  @author yixi
*/
#include <stdio.h>

int tak(int x, int y, int z) {
	if ( y < x ) return 1 + tak( tak(x-1, y, z), tak(y-1, z, x), tak(z-1, x, y) );
	else return z;	
}

int main(){
	int a,b,c;
	a=10*(getchar()-'0')+getchar()-'0';getchar();
	b=10*(getchar()-'0')+getchar()-'0';getchar();
	c=getchar()-'0';
	printf("%d\n", tak(a,b,c));
	return 0;
}
