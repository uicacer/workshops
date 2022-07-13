//--------------------------------------------------
//
//   This is a MPI program to perform 
//   numerical integration by using
//   the Trapeziod Rule
//--------------------------------------------------

// To compile, issue this command:
//  mpicxx -o numericalInt numericalInt.cpp

// To run:
/* mpirun -np numproc ./numericalInt n a b

Where,
- numproc is the number of processors
- n is the number of intervals that we want to divide from [a,b]
- a is the start point for integration
- b is the end point of the integration
*/
// e.g mpirun -np 8 ./numericalInt 1000000 0 1

#include <mpi.h>
#include <iostream>
#include <cstdlib>
#include <cmath>

using namespace std;

double f(double x);  
double Trapezoid(double local_a, int local_n, double h);  

int main(int argc, char** argv)
{
  int my_rank, p;
  double a=0.0, b=1.0;
  int n = 1000000000;

  /*h is the base of the segment*/
  double h = (b-a)/n; 
  double local_a;    // this is the starting point of the integral of each process
  double local_int = 0; // this holds the integral computed by each process (local)
  double total_int = 0;    // this holds the total of all the integrals (global)
  int local_n;      // this is the the number of subintervals for each process
	
  // Now initializes MPI and get the rank for each processes and the number of processes p
  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
  MPI_Comm_size(MPI_COMM_WORLD, &p);

  double startWTime;
  if(my_rank ==0)
    {
      startWTime = MPI_Wtime();
    }
  local_n = n/p;   			// fair method -- divide total n with number of processes
  local_a = a+my_rank*(b-a)/p;		// Starting point of each integration for each process
  local_int = Trapezoid(local_a,local_n,h);  // find the integral for each process
		
	// At last output the result
  double endWTime;
  if(my_rank !=0){
    printf("\tPE[%d] SEND: For %d trapezoids, local estimate=%f\n",my_rank, local_n, local_int);
    MPI_Send(&local_int, 1, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD);
  }
  else {
    total_int = local_int;
    for (int source = 1; source < p; source++) {
      MPI_Recv(&local_int, 1, MPI_DOUBLE, source, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
      printf("\tPE[%d] RECV from PE[%d]: local estimate=%f \n", my_rank,source, local_int);
      total_int += local_int;
    }
    endWTime = MPI_Wtime();
    cout<<"\nWith n == "<<n<<" intervals, our estimate"<<endl;
    cout<<"of the integral from "<<a<<" to "<<b<<" is "<<total_int<<endl;
    cout<<"Number of processors used = "<<p<<endl;
    cout<<"Time elapsed: "<<(endWTime-startWTime)*1000<<"ms"<<endl;
    fflush(stdout); 
  }
  MPI_Finalize();
  return 0;
}


double Trapezoid(double left_edge, int n, double h){
  // Area = h* [ f(x_o)/2 + f(x_1) + f(x_2) + ... f(x_n-1) + f(x_n)/2]
  double x;
  double right_edge = left_edge + n*h;
  double area = (f(left_edge) + f(right_edge))/2.0;
  for(int i =1; i< n; i++)
    {
      x=left_edge + i*h;
      area += f(x);
    }
  area = area * h;
  return(area);
}

double f(double x){
	double return_val;
	
	return_val = 4.0 / (1.0 + x*x); 
	return return_val;
}
