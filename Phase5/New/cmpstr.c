char * str1 = "abcdef";
char * str2 = "abcedf";

int main() {
    int i=0;
    for(;i<6;i++){
        if(str1[i]!=str2[i]){
            printf("%d:%c %c",i,str1[i],str2[i]);
            break;
        }
    }
}