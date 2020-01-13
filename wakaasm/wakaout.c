#include <stdio.h>

char* out(char* buf, int n) {
  for (int i = 0; i < n; i++) {
    printf("%02x",  *buf & 0xff);
    buf++;
    if (i < n - 1)
      printf(" ");
  }
  printf("\n");
  return buf;
}
int main(int argc, char** argv) {
  FILE* fp = fopen(argv[1], "rb");
  char buf[31];
  char*p = buf;
  fread(p, 31, 1, fp);
  fclose(fp);
  p = out(p, 5);
  p = out(p, 7);
  p = out(p, 5);
  p = out(p, 7);
  p = out(p, 7);
  return 0;
}
