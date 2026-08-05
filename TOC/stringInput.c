//program to input string to show substring 
#include <stdio.h>
#include<string.h>

int main(){
    char str[100];
    printf("Enter string:");
    fgets(str, 100, stdin);

    int len = strlen(str);
    printf("The given string is: %s",str);
    
    

  return 0;
}
