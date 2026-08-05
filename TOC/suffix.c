#include <stdio.h>

int main(){

  char str[] = "Deerwalk";
  int len = sizeof(str)/sizeof(char);

  for(int i=0; i<len; i++){
    for(int j=i; j<len; j++){
      printf("%c", str[j]);
    }
    printf("\n");
  }

  return 0;
}
