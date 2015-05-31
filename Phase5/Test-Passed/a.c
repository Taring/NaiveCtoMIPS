#include <stdio.h>

int f(int x, int y, int z, int t) {
    if (x == 10)
        return x;
    return f(x + 1, z, y, t);
}

int main() {

    printf("%d\n", f(2, 0, 0, 0));

    return 0;
}