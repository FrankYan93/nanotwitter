#include <stdio.h>
#include <stdlib.h>


int main(){
  char * board = "ABCD";
  char * s = malloc(sizeof(char)*4);
  for(int i = 0; i < 4; i++){
    s[i] = board[i];
  }
}
