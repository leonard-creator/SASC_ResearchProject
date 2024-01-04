#!/bin/bash

#SBATCH --job-name=fitlerBAM       # Job name
#SBATCH --output=filterBAM_secondary.%J.out         # Output file name
#SBATCH --error=filterBAM_secondary.%J.err          # Error file name
#SBATCH --partition=all               # Partition short max 1h, use all for more
#SBATCH --time=2:30:00                 # Time limit
# SBATCH --partition=gpu
# SBATCH --gres=gpu:1
# SBATCH --ntasks=1
# SBATCH --cpus-per-task=16

# SBATCH --nodes=2                      # Number of nodes
# SBATCH --ntasks-per-node=24             # MPI processes per node, only 1 node is reserved !
#SBATCH -n 24                          # reserves n tasks/cores on multiple shared nodes (24 x 4 nodes)

hostname

cd /exports/sascstudent/ltiling/LUMC/bamData
module purge
module load tools/miniconda/python3.9/4.12.0
conda activate biotools

echo 'File size before filtering:'
ls -sha

samtools view -F 256 -@24 -b HG002_GRCh38_ONT-UL_UCSC_20200508.phased.bam -o HG002_GRCh38_ONT-UL_UCSC_20200508.phased.filter256.bam

echo 'File size after filtering:'
ls -sha
