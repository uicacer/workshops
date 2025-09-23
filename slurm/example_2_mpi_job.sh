#!/bin/bash
#SBATCH --job-name=hello_mpi
#SBATCH --time=00:10:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4
#SBATCH --account=ts_acer_chi
#SBATCH --partition=batch
#SBATCH --output=hello_mpi.%j.out # %j will be replaced with the job ID

# Move to the directory where the job was submitted
cd $SLURM_SUBMIT_DIR

# Setup MPI programming environment
module load OpenMPI/4.1.6-GCC-13.2.0 
module load UCX/1.16.0-GCCcore-13.3.0
export OMPI_MCA_btl='^uct,ofi'
export OMPI_MCA_pml='ucx'
export OMPI_MCA_mtl='^ofi'


# Uncomment the next line to compile your MPI program (if needed)
mpicc -O2 example_2_code.c -o example_2_code

# Run mpi job
mpirun example_2_code

