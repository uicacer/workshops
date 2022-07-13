#!/bin/bash
#PBS -N hello_mpi
#PBS -l walltime=00:10:00
#PBS -l nodes=2:ppn=4
#PBS -q ood
#PBS -j oe
#
## Move to the directory where the job was submitted
#
cd $PBS_O_WORKDIR
#
#  setup MPI programming environment
#
module load OpenMPI/3.1.4-GCC-8.3.0

export OMPI_MCA_mca_base_component_show_load_errors=0
export PMIX_MCA_mca_base_component_show_load_errors=0
#
# Run mpi job
#
mpirun -machinefile $PBS_NODEFILE -np $PBS_NP ./mpi-hello


