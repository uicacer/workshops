/******************************************************************************************************

  Sample Matrix-Matrix multiplication code for Profiling tutorial

*******************************************************************************************************/



#include <iostream>
#include <stdlib.h>
#include <omp.h>
// #include <mkl.h>
#include <sys/time.h>
using namespace std;


//2D matrix-matrix multiplication
void mm1(double **A, double **B, double **C, int matrix_size) {
  for (int i = 0 ; i < matrix_size; i++) {
    for (int j = 0;  j < matrix_size; j++) {
      for (int k = 0; k < matrix_size; k++) {
	C[i][j] += A[i][k] * B[k][j];
      }
    }
  }
}

//Alternative 2D matrix-matrix multiplication
void mm2(double **A, double **B, double **C, int matrix_size) {

      for (int i = 0 ; i < matrix_size; i++) {
	for (int k = 0; k < matrix_size; k++) {
	  for (int j = 0;  j < matrix_size; j++) {
	    C[i][j] += A[i][k] * B[k][j];
	}
      }
    }

}

//1D matrix-matrix multiplication
void mm3(double *a, double *b, double *c, int matrix_size) {

  for (int i=0 ; i<matrix_size; i++) {
    int idx = i*matrix_size;
    for (int k=0;  k<matrix_size; k++) {
      for (int j=0; j<matrix_size; j++) {
        c[idx+j] += a[idx+k]*b[k*matrix_size+j];
      }
    }
  }
}


//function to print a few elements to std out to use as a check (2D version)
void print_check(double **Z, int matrix_size) {

  cout<<Z[0][0]<<" "<<Z[1][1]<<" "<<Z[2][2]<<endl;
}

//function to print a few elements to std out to use as a check (1D version)
void print_check_1D(double *Z, int matrix_size) {

  cout<<Z[0]<<" "<<Z[matrix_size+1]<<" "<<Z[2*matrix_size+2]<<endl;

}


//zeros all elements of input array (2D version)
void zero_result(double **C, int matrix_size) {
  for (int i = 0 ; i < matrix_size; i++) {
    for (int j = 0;  j < matrix_size; j++) {
        C[i][j] = 0.0;
    }
  }
}

//zeros all elements of input array (1D version)
void zero_result_1D(double *C, int matrix_size) {
  for (int i = 0 ; i < matrix_size*matrix_size; i++) {
        C[i] = 0.0;
    }
  }
