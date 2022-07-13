#include <omp.h>
#include <stdio.h>
static long num_steps = 1000000000;
double step;
int main() {

  #pragma omp parallel
  {
     printf("Hello World.\n");
  }
}

