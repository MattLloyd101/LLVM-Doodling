#include <stdio.h>


int testFunc(int x, int y) {
  printf("hello world - %d\n", x);
  printf("hello world - %d\n", y);
  return x + y;
}


int main() {
  
  testFunc(1, 2);
  return 0;
}