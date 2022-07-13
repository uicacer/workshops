/*
 * Compute pi by approximating the area under the curve f(x) = 4 / (1 + x*x)
 * between 0 and 1 using the Trapezoidal Rule.
 *
 * Parallel version using OpenMP
 */
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <omp.h>	/* OpenMP */

double getusec_() {
        struct timeval time;
        gettimeofday(&time, NULL);
        return ((double)time.tv_sec * (double)1e6 + (double)time.tv_usec);
}

#define START_COUNT_TIME stamp = getusec_();
#define STOP_COUNT_TIME(_m) stamp = getusec_() - stamp;\
                        stamp = stamp/1e6;\
                        printf ("%s%0.6f\n",(_m), stamp);

int main(int argc, char *argv[]) {
    double stamp;
    START_COUNT_TIME;

    double x, sum=0.0, pi=0.0;
    double step;

    long int num_steps = 1000000000;
    step = 1.0/(double) num_steps;

    /* OpenMP code starts here*/
    #pragma omp parallel private(x) reduction(+: sum) 
    {
        long int myid = omp_get_thread_num();
	long int howmany = omp_get_num_threads();
        for (long int i=myid; i<num_steps; i+=howmany) {
            x = (i+0.5)*step;
            sum += 4.0/(1.0+x*x);
        }
    }
    pi = step * sum;

    /* print results */
    printf("Number pi after %ld iterations = %.15f\n", num_steps, pi);

    STOP_COUNT_TIME("Execution time (secs.): ");

    return EXIT_SUCCESS;
}
