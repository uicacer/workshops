// Estimating pi using the dartboard algorithm

#include <stdio.h>
#include <stdlib.h>

// our function for throwing darts and estimating pi
double dartboard(long ndarts)
{
  double x, y, r, pi; 
  int n, hits;
  hits = 0;

  // throw darts
  for (n = 1; n <= ndarts; n++)  {
    // (x,y) are random between -1 and 1
    r = (double)random()/RAND_MAX;
    x = (2.0 * r) - 1.0;
    r = (double)random()/RAND_MAX;
    y = (2.0 * r) - 1.0;
    // if our random dart landed inside the unit circle, increment the score
    if (((x*x) + (y*y)) <= 1.0) {
      hits++;
    }
  }

  // estimate pi
  pi = 4.0 * (double)hits / (double)ndarts;
  return(pi);
} 

// the main program
int main (int argc, char *argv[])
{
  const long NDARTS=500000000;

  double my_pi, mean_pi, err;

  // initialize random number generator
  random ();

  printf ("Running serial dartboard calculation of PI\n"); 

  mean_pi = dartboard(NDARTS);
  err = mean_pi - 3.14159265358979323846;
  printf("%d throws: mean_pi %.12f: error %.12f\n",
             NDARTS, mean_pi, err);
  return 0;
}
