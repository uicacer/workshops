#!/bin/bash
#SBATCH --job-name=hello_mpi          # Give this job a descriptive name that will appear in job queues
#SBATCH --time=00:10:00               # Maximum runtime: 10 minutes (format: HH:MM:SS)
#SBATCH --nodes=2                     # Request 2 compute nodes from the cluster
#SBATCH --ntasks-per-node=4           # Run 4 MPI processes on each node (total: 2×4=8 processes)
#SBATCH --account=ts_acer_chi         # Charge compute time to this specific account/project
#SBATCH --partition=batch             # Submit to the "batch" queue (different partitions have different resources)
#SBATCH --output=hello_mpi.%j.out     # Save program output to this file (%j gets replaced with actual job ID)

# Move to the directory where the job was submitted from
# $SLURM_SUBMIT_DIR is an environment variable set by SLURM containing the submission directory path
cd $SLURM_SUBMIT_DIR

# Setup MPI programming environment by loading required software modules
# These modules make MPI libraries and compilers available to your job
module load OpenMPI/4.1.6-GCC-13.2.0    # Load OpenMPI version 4.1.6 compiled with GCC 13.2.0
module load UCX/1.16.0-GCCcore-13.3.0    # Load UCX (communication library) version 1.16.0

# Configure OpenMPI communication settings for optimal performance
# These environment variables tell OpenMPI which communication methods to use or avoid
export OMPI_MCA_btl='^uct,ofi'           # Don't use UCT or OFI byte transport layers (^ means "exclude")
export OMPI_MCA_pml='ucx'                # Use UCX as the point-to-point messaging layer
export OMPI_MCA_mtl='^ofi'               # Don't use OFI matching transport layer

# Compile the MPI C program into an executable
# mpicc is the MPI C compiler wrapper that links in MPI libraries automatically
# -O2 enables compiler optimizations for better performance
# mpi-hello.c is the source file, -o mpi-hello creates executable named "mpi-hello"
mpicc -O2 mpi-hello.c -o mpi-hello

# Run the MPI program across all requested processes
# mpirun automatically distributes the program across nodes based on SLURM allocation
# It will run 8 total processes (2 nodes × 4 processes per node)
mpirun mpi-hello
