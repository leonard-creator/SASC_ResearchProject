#!/bin/bash

#SBATCH --job-name=vcf_prepro       # Job name
#SBATCH --output=preproc_VCF.%J.out         # Output file name
#SBATCH --error=preproc_VCF.%J.err          # Error file name
#SBATCH --partition=all,short               # Partition short max 1h, use all for more
#SBATCH --time=01:00:00                 # Time limit
#SBATCH --mem=20GB
#SBATCH --nodes=1                       # Number of nodes
#SBATCH --ntasks-per-node=8             # MPI processes per node, only 1 node is reserved !


# Activate the Conda environment "biotools"
cd /exports/sascstudent/ltiling/LUMC/VCF_Results/
module purge
module load tools/miniconda/python3.9/4.12.0
conda activate biotools


#Check if a file path was provided as an argument
if [ "$#" -ne 2 ]; then
    echo "Usage: $1 <path_to_vcf_file> and <output-dir-name-truvari> :  sbatch preprocess_vcf.sh HG002_GRCh38/HG002_ONT_Grch38_chr1_bigmem.svision.s5.vcf tv_hg2TrXchrSV"
    exit 1
fi

# Extract the VCF file name and the name for the output folder from the provided path from the command line 
input_file="$1"
output_name="$2"
vcf_file=$(basename "$input_file")
filename=${vcf_file%.vcf}
directory_path="/exports/sascstudent/ltiling/LUMC/VCF_Results/HG002_GRCh38"

echo $input_file
echo $output_name
echo $vcf_file
echo $filename
echo $directory_path

# enter output dir name
out="/exports/sascstudent/ltiling/LUMC/VCF_Results/truvari_out/$output_name"
ref="/exports/sascstudent/samvank/data/refData/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta"
comp="/exports/sascstudent/samvank/data/vcfData/HG002/38/HG002_tier1_38_sorted.vcf.gz"


# Step 1: Echo the file name
echo "Processing VCF file: $vcf_file"
cd $directory_path
pwd

# Step 2: Sort the VCF file with bcftools
bcftools sort "$vcf_file" -o "$vcf_file"

# Step 3: Make a copy of the sorted VCF 
#copy_vcf="$filename.copy"
#cp "$vcf_file" "$copy_vcf"


# rename chromosomes for consistency: chr1 --> 1 
bcftools annotate --rename-chrs "../rename_CHR.txt" $vcf_file > ${vcf_file%.vcf}.an.vcf
#new annotaded file
an_vcf=${vcf_file%.vcf}.an.vcf

# Create a usable shortcut name and NORMALIZE, DECOMPOSE the file
shortenedFile=${an_vcf%.vcf}
vt normalize -n -r "$ref" "$an_vcf" -o "${shortenedFile}.norm.vcf"
vt decompose "${shortenedFile}.norm.vcf" -o "${shortenedFile}.norm.dec.vcf"
bgzip "${shortenedFile}.norm.dec.vcf"
tabix -p vcf "${shortenedFile}.norm.dec.vcf.gz"

#exact filename
clean_vcf=${shortenedFile}.norm.dec.vcf.gz


# Step 5: Pass the file to the truvari bench command with the flag --pctseq=0
truvari_bench_command="truvari bench --pctseq=0 -b $comp -c $clean_vcf -o $out"
eval "$truvari_bench_command"

# Step 6: Echo the completion message
echo "completed."



