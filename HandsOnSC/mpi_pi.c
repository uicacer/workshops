// Estimating pi using the dartboard algorithm
// All processes contribute to the calculation, with the
// master process averaging the values for pi.
// We then use mpc_reduce to collect the results
//
// mpicc -o go mpi_pi_reduce.c
// mpirun -n 8 go

#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#define MASTER 0         // task ID of master task
// #define NDARTS 10000000000      // # dart throws per round
#define NROUNDS 10     // # of rounds of dart throwing

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

  double my_pi, pi_sum, pi_est, mean_pi, err;
  int task_id, n_tasks, rc, i;
  MPI_Status status;

  // Obtain number of tasks and task ID
  MPI_Init(&argc,&argv);
  MPI_Comm_size(MPI_COMM_WORLD,&n_tasks);
  MPI_Comm_rank(MPI_COMM_WORLD,&task_id);
  //  printf ("task %d of %d reporting for duty...\n", task_id, n_tasks);

  // different seed for random number generator for each task
  srandom (task_id);

  if (task_id == MASTER){
    printf ("\nRunning MPI dartboard calculation of PI\n"); 
    printf ("Number of Processes: %d\n",n_tasks);
    printf ("Number of Rounds/proc: %d;  Number of Darts/proc: %d\n", NROUNDS,NDARTS);
    // printf ("Total # of throws: %d\n",NROUNDS*NDARTS*n_tasks);
  }

  mean_pi = 0.0;
  for (i=0; i<NROUNDS; i++) {
    // all tasks will execute dartboard() to calculate their own estimate of pi
    my_pi = dartboard(NDARTS);

    // now we use MPI_Reduce() to sum values of my_pi across all tasks
    // the master process (id=MASTER) will store the accumulated value
    // in pi_sum. We tell MPI_Reduce() to sum by passing it
    // the MPI_SUM value (define in mpi.h)
    rc = MPI_Reduce(&my_pi, &pi_sum, 1, MPI_DOUBLE, MPI_SUM,
                    MASTER, MPI_COMM_WORLD);

    // now, IF WE ARE THE MASTER process, we will compute the mean
    if (task_id == MASTER) {
      pi_est = pi_sum / n_tasks;
      mean_pi = ( (mean_pi * i) + pi_est ) / (i + 1); // running average
      err = mean_pi - 3.14159265358979323846;
      //printf("%d throws: mean_pi %.12f: error %.12f\n",
      //       (NDARTS * (i + 1)), mean_pi, err);
    }
  }
  if (task_id == MASTER) {
    err = mean_pi - 3.14159265358979323846;
    printf("\nThe estimated value of pi is: %.12f,  error %.12f\n", mean_pi, err);
    printf ("PS, the real value of pi is about 3.14159265358979323846\n");
  }
  MPI_Finalize();
  return 0;
}
