#!/bin/bash

# SLURM Job Configuration
#SBATCH --job-name=param_sweep          # Job name (shows up in squeue)
#SBATCH --time=30:00                    # 30 minutes per job (wall time limit)
#SBATCH --nodes=1                       # Use 1 compute node
#SBATCH --ntasks=1                      # Run 1 task per node
#SBATCH --array=1-5                     # Run 5 different parameter sets (array indices 1-5)
#SBATCH --partition=batch               # Submit to batch partition
#SBATCH --account=ts_acer_chi          # Replace with your actual account name

# Email Notifications
#SBATCH --mail-type=BEGIN,END,FAIL      # Send email when job starts, ends, or fails
#SBATCH --mail-user=nassar@uic.edu  # Replace with your actual email address

# Output and Error Files
#SBATCH --output=logs/param_sweep_%A_%a.out  # %A = job array ID, %a = task ID
#SBATCH --error=logs/param_sweep_%A_%a.err   # Separate error file for each array task

# Create logs directory if it doesn't exist
mkdir -p logs

# Load required modules
module load python3  # or use 'module load python39' for Python 3.9 specifically

# Define parameter values array
PARAM_VALUES=(0.1 0.5 1.0 2.0 5.0)

# Get parameter value for this array task (arrays are 0-indexed, SLURM tasks start at 1)
PARAM_VALUE=${PARAM_VALUES[$((SLURM_ARRAY_TASK_ID - 1))]}

echo "Task $SLURM_ARRAY_TASK_ID starting with parameter: $PARAM_VALUE"

# Run the simulation
python example_4_parameter_study_code.py --param $PARAM_VALUE --output results_${SLURM_ARRAY_TASK_ID}.dat

