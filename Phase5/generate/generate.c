/** Target: Spill the variables from the register allocation when there are too many of them.
 * Possible optimization: Inline function
 * REMARKS: Pay attention to the size of the stack(heap).
 *
**/
#include <stdio.h>
#include <stdlib.h>
int main() {

    int n = 1, i;

    printf("#include <stdio.h>\n#include <stdlib.h>\n");
    printf("\nint getcount(int* count) {\n\treturn ++(*count);\n}\n");

    printf("int main() {\n");
    printf("\tint* count;\n");
    for (int i = 0; i < n; ++i)
        printf("\tint v%d;\n", i);
    printf("\n\tcount = malloc(sizeof(int));\n");
    printf("\t*count = 0;\n");
    for (int i = 0; i < n; ++i)
    printf("\tv%d = getcount(count);\n", i);
    printf("\n");
     for (int i = 0; i < n; ++i)
    printf("\tprintf(\"%%d \",v%d);\n", i);
    printf("\tprintf(\"\\n\");\n");
      for (int i = 0; i < n; ++i)
    printf("\tprintf(\"%%d \",v%d);\n", i);
    printf("\tprintf(\"\\n\");\n");
    printf("\treturn 0;\n");
    printf("}\n");
}

