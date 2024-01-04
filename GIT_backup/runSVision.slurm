#!/bin/bash

#SBATCH --job-name=hg5SV       # Job name
#SBATCH --output=sv_hg5_t24def.%J.out         # Output file name
#SBATCH --error=sv_hg5_t24def.%J.err          # Error file name
#SBATCH --partition=all,highmem               # Partition short max 1h, use all for more
#SBATCH --time=24:00:00                 # Time limit
# SBATCH --partition=gpu
# SBATCH --gres=gpu:1
# SBATCH --ntasks=1
# SBATCH --cpus-per-task=16

#SBATCH --mem=190GB
#SBATCH --nodes=1                       # Number of nodes
#SBATCH --ntasks-per-node=24             # MPI processes per node, only 1 node is reserved !
# SBATCH -n 72 				# reserves n tasks/cores on multiple shared nodes (24 x 4 nodes)

# 20h t20 until chr3, too slow process, hangs in chr2 and chr3 for 5h --> hg2GRCH38
# 4h same parameter almost done >>chrY for 3h --> hg2GRCH38
# 6h t24  until chr2, stuck for an hour multiple times --> hg5GRCH38
# >30h t24 almost done ! stuck in last chroms --> hg5GRCH38




echo "Running on hosts: $SLURM_JOB_NODELIST"
echo "Running on $SLURM_JOB_NUM_NODES nodes."
echo "Running $SLURM_NTASKS tasks."
echo "Account: $SLURM_JOB_ACCOUNT"
echo "Job ID: $SLURM_JOB_ID"
echo "Job name: $SLURM_JOB_NAME"
echo "Node running script: $SLURMD_NODENAME"

hostname

cd /exports/sascstudent/ltiling/LUMC/SVision/
module purge
module load tools/miniconda/python3.9/4.12.0
conda activate svisionenv
echo 'workdir:'
pwd
echo 'optional Parameters:' #-s=5 -maxsv=1   maxsv=2 results in empty outputs file error...
echo 'mem=190GB, -c=FULL, -s min support read number for SV calling=5 , -min_mapq min mapping quality = 10, min_sv_size to detect = 50, max_sv_size = 1Mbp , tasks =24, nodes=1 , graph=False'

echo 'starting SVision'

# FOR HG005 ON GRCh38
SVision -o svision_out/ -b /exports/sascstudent/samvank/data/bamData/HG005/HG005_GRCh38_ONT-UL_UCSC_20200109.phased.bam -m svision_model/svision-cnn-model.ckpt -g /exports/sascstudent/samvank/data/refData/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -n HG005_ONT_Grch38_t24def -s 5 --qname -t 24 --min_sv_size 50

# FOR HG005 ON GRCH38 WITH SINGLE CHROMOSOME
#SVision -o svision_out/ -b /exports/sascstudent/samvank/data/bamData/HG005/HG005_GRCh38_ONT-UL_UCSC_20200109.phased.bam -m svision_model/svision-cnn-model.ckpt -g /exports/sascstudent/samvank/data/refData/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -n HG005_ONT_Grch38_chr3_t8 -s 5 --qname -t 8 -c 'chr17'

# FOR HG002 ON GRCh38
#SVision -o svision_out/ -b /exports/sascstudent/ltiling/LUMC/bamData/HG002_GRCh38_ONT-UL_UCSC_20200508.phased.bam -m svision_model/svision-cnn-model.ckpt -g /exports/sascstudent/samvank/data/refData/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -n HG002_ONT_Grch38_t4def -s 5 --qname -t 4 --min_sv_size 50 -j $SLURM_JOB_ID

# FOR HG002 ON GRCh38 WITH SINGLE CHROMOSOME
#SVision -o svision_out/ -b /exports/sascstudent/ltiling/LUMC/bamData/HG002_GRCh38_ONT-UL_UCSC_20200508.phased.bam -m svision_model/svision-cnn-model.ckpt -g /exports/sascstudent/samvank/data/refData/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -n HG002_ONT_Grch38_chr2 -s 5 --qname -t 8 -c 'chr2' -f 13

# FOR DEMO DATA
#SVision -o svision_out/ -b supports/HG00733.svision.demo.bam -m svision_model/svision-cnn-model.ckpt -g supports/GRCh38_full_analysis_set_plus_decoy_hla.fa -n Test_Svisiondemodata -s 2 --graph --qname
