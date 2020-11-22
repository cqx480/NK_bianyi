#include<stdio.h>

int main(){

    int i, n, f;

    scanf("%d", &n);
    f = 1; 
    i = 2;
    
    while (i <= n)
    { 
        f = f * i;
        i = i + 1;
    }   
    
    printf("result is: %d\n",f);

    return 0;
}