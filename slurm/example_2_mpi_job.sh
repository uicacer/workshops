#!/bin/bash
#SBATCH --job-name=mpi_parallel
#SBATCH --time=4:00:00         # 4 hours
#SBATCH --nodes=2              # Use 2 nodes
#SBATCH --ntasks-per-node=8    # 8 tasks per node (16 total)
#SBATCH --partition=batch
#SBATCH --account=ts_acer_chi
#SBATCH --output=output_from_example_2.txt

echo "Starting MPI job with $SLURM_NTASKS total tasks"
echo "Using $SLURM_JOB_NUM_NODES nodes"

# Load required modules (adjust based on available modules)
module load gcc/11.2.0
module load openmpi/mlnx/gcc/64/4.1.5a1

# Compile your program
#mpicxx -O2 example_2_code.cpp -o example_2_code
/cm/shared/apps/mpich/ge/gcc/64/3.4.2/bin/mpicxx -O2 example_2_code.cpp -o example_2_code

# Run with SLURM's srun
srun ./example_2_code

echo "MPI job completed"
