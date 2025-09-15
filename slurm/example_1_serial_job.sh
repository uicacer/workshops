#!/bin/bash

# SLURM job configuration for a simple serial (single-threaded) job
#SBATCH --job-name=my_serial_job
#SBATCH --time=1:00:00         # Maximum runtime: 1 hour
#SBATCH --nodes=1              # Use 1 compute node
#SBATCH --ntasks=1             # Run 1 task (single process)
#SBATCH --partition=batch      # Submit to default CPU partition
#SBATCH --account=ts_acer_chi  # Billing account for resource tracking
#SBATCH --output=hello_world_output.txt  # Save all output to this file

# Print job information for debugging and verification
echo "Job started at: $(date)"                    # Current date and time when job begins
echo "Running on node: $(hostname)"               # Which compute node is running this job
echo "Job ID: $SLURM_JOB_ID"                     # Unique job ID assigned by SLURM
echo "Partition: $SLURM_JOB_PARTITION"           # Which partition/queue the job is running on

# Your actual computational work goes here
python example_1_code.py                               # Run your Python script

echo "Job finished at: $(date)"                  # Record when the job completed
