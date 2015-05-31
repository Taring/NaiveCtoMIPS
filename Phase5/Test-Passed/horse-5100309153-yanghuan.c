#include <stdio.h>

int N;
int head, startx, starty;
int targetx, targety;
int x, y;
int xlist[12000], ylist[12000], tail, ok, now;
int step[106][106];
int i, j;
int check(int a, int N) {
    return ((a < N) && (a >= 0));
}

int addList(int x, int y) {
    if (check(x, N) == 1 && check(y, N) == 1 && step[x][y] == -1) {
        tail = tail + 1;
        xlist[tail] = x;
        ylist[tail] = y;
        step[x][y] = now + 1;
        if ((x == targetx) && (y == targety)) ok = 1;
    }
}

int main() {
    N = 100*(getchar()-'0')+10*(getchar()-'0')+getchar()-'0';
    targetx = targety  = N - 1;
    for (i = 0; i < N; i ++)
        for (j = 0; j < N; j ++)
        step[i][j] = -1;
    while (head <= tail) {
        x = xlist[head];
        y = ylist[head];
        now = step[x][y];
        addList(x-1, y-2);
        addList(x-1, y+2);
        addList(x+1, y-2);
        addList(x+1, y+2);
        addList(x-2, y-1);
        addList(x-2, y+1);
        addList(x+2, y-1);
        addList(x+2, y+1);
        if (ok == 1) break;
        head = head + 1;
    }
    if (ok == 1) printf("%d\n", step[targetx][targety]);
    else printf("no solution!\n");
    return 0;
}
