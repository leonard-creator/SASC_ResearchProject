#!/bin/bash

# workdir
echo pwd

# Define the list of chromosome identifiers
# chr1 is already passed
chromosomes=("chr1","chr2" "chr3" "chr4" "chr5" "chr6" "chr7" "chr8" "chr9" "chr10" "chr11" "chr12" "chr13" "chr14" "chr15" "chr16" "chr17" "chr18" "chr19" "chr20" "chr21" "chr22" "chrX" "chrY" "chrM")

# create the bamfile HG002
#samtools view -H -b HG002_GRCh38_ONT-UL_UCSC_20200508.phased.bam > reduced_bams/HG002_GRCh38_ONT-UL_UCSC_20200508.phased.cleaned.bam

#create the bamfile HG005
samtools view -H -b /exports/sascstudent/samvank/data/bamData/HG005/HG005_GRCh38_ONT-UL_UCSC_20200109.phased.bam > reduced_bams/HG005_GRCh38_ONT-UL_UCSC_20200109.phased.cleaned.bam

# activate conda environment 
module purge
module load tools/miniconda/python3.9/4.12.0
conda activate biotools

# Loop through the list and execute the samtools command
for chromosome in "${chromosomes[@]}"; do
    command="samtools view -@20 -b /exports/sascstudent/samvank/data/bamData/HG005/HG005_GRCh38_ONT-UL_UCSC_20200109.phased.bam $chromosome >> reduced_bams/HG005_GRCh38_ONT-UL_UCSC_20200109.phased.cleaned.bam"
    echo "Executing: $command"
    eval $command
done

# index new bamfile
samtools index -@20 HG005_GRCh38_ONT-UL_UCSC_20200109.phased.cleaned.bam -o HG005_GRCh38_ONT-UL_UCSC_20200109.phased.cleaned.bam.bai


# for HG002
#command="samtools view -@20 -b HG002_GRCh38_ONT-UL_UCSC_20200508.phased.bam $chromosome >> reduced_bams/HG002_GRCh38_ONT-UL_UCSC_20200508.phased.cleaned.bam"
