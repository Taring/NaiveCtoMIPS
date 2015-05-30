/*
struct和union的区别
Sample Input:
b
10

Sample Outut
b 98
b 0

 10
b 10
*/

#include <stdio.h>
 
union node1
{
     char mark;
     int num;
}a;
 
struct node2
{
     char mark;
     int num;
}b;

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
     char c = getchar();int x = get_d();
     a.mark = c;
     printf("%c %d\n",a.mark,a.num);
     b.mark = a.mark;
     printf("%c %d\n",b.mark,b.num);
     a.num = x;
     printf("%c %d\n",a.mark,a.num);
     b.num=a.num;
     printf("%c %d\n",b.mark,b.num);
     return 0;
}
