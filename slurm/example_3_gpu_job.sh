#!/bin/bash

# SLURM job configuration
#SBATCH --job-name=gpu_job
#SBATCH --time=2:00:00         # Maximum runtime: 2 hours
#SBATCH --nodes=1              # Use 1 compute node
#SBATCH --ntasks=1             # Run 1 task (process)
#SBATCH --partition=batch_gpu  # Submit to GPU partition
#SBATCH --gpus-per-node=1      # Request 1 GPU
#SBATCH --account=ts_acer_chi  # Billing account
#SBATCH --output=output_from_example_3_cuda.txt  # Output file

# Print job information for debugging and tracking
echo "GPU job starting on node: $(hostname)"          # Shows which physical machine is running our job
echo "GPU allocated: $CUDA_VISIBLE_DEVICES"           # Shows the GPU ID assigned to this job

# Load CUDA compiler and libraries
module load cuda12.2/toolkit/12.2.2

# Check what GPU we got and its status
nvidia-smi

# Compile the CUDA source code into an executable
nvcc -o example_3_cuda_code example_3_cuda_code.cu

# Run the compiled GPU program
./example_3_cuda_code

echo "GPU job completed"
