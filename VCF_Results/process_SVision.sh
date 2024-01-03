#!/bin/bash

# Pipeline to preprocess SVision-vcf results for truvari use
# Activate the Conda environment "biotools"
cd /exports/sascstudent/ltiling/LUMC/VCF_Results/
module purge
module load tools/miniconda/python3.9/4.12.0
conda activate biotools


#Check if a file path was provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $1 <path_to_vcf_file> and <output-dir-name-truvari> : sbatch preprocess_vcf.sh HG002_GRCh38/HG002_ONT_Grch38_chr1_bigmem.svision.s5.vcf"
    exit 1
fi

# Extract the VCF file name and the name for the output folder from the provided path from the command line
input_file="$1"
vcf_file=$(basename "$input_file")
filename=${vcf_file%.vcf}
directory_path=$(dirname "$input_file")


echo $input_file
echo $vcf_file
echo $filename
echo $directory_path


######START THE PREPROCESSING######
cd $directory_path

# sorting
bcftools sort $vcf_file -o ${filename}.sort.vcf

# rename chromosomes for consistency: chr1 --> 1
bcftools annotate --rename-chrs "../rename_CHR.txt" ${filename}.sort.vcf > ${filename}.sort.an.vcf
# clean up
rm ${filename}.sort.vcf

# change FILTER=Covered to FILTER=PASS only in FILTER=SV to filter out CSV and only compare INS DEL
# with that, its possible to avoid CVS in truvari using --passonly option and include them without that flag
awk -F'\t' -v OFS='\t' '$5 !~ /<CSV>/ && $7 == "Covered" { $7 = "PASS" } 1' ${filename}.sort.an.vcf >  ${filename}.sort.an.pass.vcf
#CSV with uncovered are ignored as well, may have quality of 0

#clean up
rm ${filename}.sort.an.vcf

# bgzip and index
mv ${filename}.sort.an.pass.vcf ${filename}.processed.vcf
bgzip ${filename}.processed.vcf && tabix -p vcf ${filename}.processed.vcf.gz


echo "processing done"
echo "truvari command for default comparison: "
echo "truvari bench --pctseq=0 --passonly --refdist=1000 --pctovl=.0 --pctsize=.7 --includebed HG002_SVs_Tier1_v0.6.bed -b /exports/sascstudent/samvank/data/vcfData/HG002/38/HG002_tier1_38_sorted.vcf.gz -f ../../Reference_genoms/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -c HG002_ONT_Grch38_full.svision.s5.processed.vcf.gz -o ../truvari_out/hg2Xsv_fin_bed"
#truvari bench --pctseq=0 --passonly --refdist=1000 --pctovl=.0 --pctsize=.5 --includebed HG002_SVs_Tier1_v0.6.bed -b /exports/sascstudent/samvank/data/vcfData/HG002/38/HG002_tier1_38_sorted.vcf.gz -f ../../Reference_genoms/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta -c HG002_ONT_Grch38_minsv80.svision.s5.processed.intersect.vcf.gz -o ../truvari_out/hg2Xsv_procIntersect
