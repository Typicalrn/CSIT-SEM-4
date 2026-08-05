#include <stdio.h>

int main(){

  char str[] = "DEERWALK";
  int str_len = sizeof(str)/sizeof(char);

  for(int i=0; i<str_len; i++){
    for(int j = 0; j<=i; j++){
      printf("%c", str[j]);
    }
    printf("\n");
  }
  return 0;
}
