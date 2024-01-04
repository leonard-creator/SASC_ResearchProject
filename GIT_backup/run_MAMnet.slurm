#!/bin/bash

#SBATCH --job-name=hg05AMnetSens       # Job name
#SBATCH --output=mamnet_hg5_sens.%J.out         # Output file name
#SBATCH --error=mamnet_hg5_sens.%J.err          # Error file name
#SBATCH --partition=all,highmem               # Partition short max 1h, use all for more
#SBATCH --time=20:00:00                 # Time limit
# SBATCH --partition=gpu
# SBATCH --gres=gpu:1
# SBATCH --ntasks=1
# SBATCH --cpus-per-task=16
#SBATCH --mem=200GB
#SBATCH --nodes=1                       # Number of nodes
#SBATCH --ntasks-per-node=16             # MPI processes per node, only 1 node is reserved !
# SBATCH -n 72                           # reserves n tasks/cores on multiple shared nodes (24 x 4 nodes)

hostname
echo "Running on hosts: $SLURM_JOB_NODELIST"
echo "Running on $SLURM_JOB_NUM_NODES nodes."
echo "Running $SLURM_NTASKS tasks."
echo "Account: $SLURM_JOB_ACCOUNT"
echo "Job ID: $SLURM_JOB_ID"
echo "Job name: $SLURM_JOB_NAME"
echo "Node running script: $SLURMD_NODENAME"

#-bamfilepath the inputs path of sort and index bam file,
#  the bam file should has MD tag which can be compuated by samtools calmd...
#-workdir the work path of MAMnet to store temporary data
#-outputpath the output path of called vcf file
#-threads the number of threads to use. (default: all available thread)
#-step data shift size [1-200]. (default: 50)
#-includecontig the list of contig to preform detection. (default: [], all contig are used)

cd /exports/sascstudent/ltiling/LUMC/MAMnet
module purge
module load tools/miniconda/python3.9/4.12.0
conda activate /exports/sascstudent/ltiling/envs/MAMnet

echo 'optional parameter settigns:'
echo 'threads 16 -step=20 ' # default=50

# run MAMnet on 256-filtered HG002
# filtered: HG002_GRCh38_ONT-UL_UCSC_20200508.phased.filter256.md.bam
# HG002_GRCh38_ONT-UL_UCSC_secondary_alginment.sorted.bam --> weird stuck at 23k - 24k after 3 min
#python MAMnet.py -bamfilepath /exports/sascstudent/ltiling/LUMC/bamData/HG002_GRCh38_ONT-UL_UCSC_20200508.phased.filter256.md.bam -workdir workdir/ -outputpath results/HG002_GRCh38_MAMnet_256Dt4.vcf -threads 4 -step 50

# run on HG005 256 filtered
python MAMnet.py -bamfilepath /exports/sascstudent/ltiling/LUMC/bamData/HG005_GRCh38_ONT-UL_UCSC_20200109.phased.filter256.md.bam -workdir workdir/ -outputpath results/HG005_GRCh38_MAMnet_256sens.vcf -threads 16 -step 20
