/* MPI program sample */
/* HPCC, Sept. 2015 */

#include <mpi.h>
#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv) {
  int world_size;
  int rank;
  char hostname[256];
  char processor_name[MPI_MAX_PROCESSOR_NAME];
  int name_len;

  // Initialize the MPI environment
  MPI_Init(&argc,&argv);

  // get the total number of processes
  MPI_Comm_size(MPI_COMM_WORLD, &world_size);

  // get the rank of current process
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);

  // get the name of the processor
  MPI_Get_processor_name(processor_name, &name_len);

  // get the hostname
  gethostname(hostname,255);

  printf("Hello world!  I am process number: %d from processor %s on host %s out of %d processors\n", rank, processor_name, hostname, world_size);

  MPI_Finalize();

  return 0;
}
