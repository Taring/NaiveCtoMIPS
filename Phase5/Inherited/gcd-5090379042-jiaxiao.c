/**
 * calculate gcd, nothing special
 * by msh
 */
#include <stdio.h>

int gcd(int x, int y) {
  if (x%y == 0) return y;
  else return gcd(y, x%y);
}

int main() {
  int a,b;
  a=10*(getchar()-'0')+getchar()-'0';getchar();
  b=10*(getchar()-'0')+getchar()-'0';getchar();
  printf("%d\n%d\n%d\n%d\n",
    gcd(10,1),
    gcd(a,b),
    gcd(34986,3087),
    gcd(2907,1539));
  return 0;
}
