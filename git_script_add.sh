# git add script 

file_list=("VCF_Results/HG002_GRCh38/HG002_SVs_Tier1_v0.6.bed" "VCF_Results/preprocess_vcf.sh" "VCF_Results/process_MAMnet.sh" "VCF_Results/process_SVision.sh" "VCF_Results/rename_CHR.txt" "VCF_Results/truvari_out/hg2XM_FIN/candidate.refine.bed" "VCF_Results/truvari_out/hg2XM_FIN/fn.vcf.gz" "VCF_Results/truvari_out/hg2XM_FIN/fn.vcf.gz.tbi" "VCF_Results/truvari_out/hg2XM_FIN/fp.vcf.gz" "VCF_Results/truvari_out/hg2XM_FIN/fp.vcf.gz.tbi" "VCF_Results/truvari_out/hg2XM_FIN/log.txt" "VCF_Results/truvari_out/hg2XM_FIN/params.json" "VCF_Results/truvari_out/hg2XM_FIN/summary.json" "VCF_Results/truvari_out/hg2XM_FIN/tp-base.vcf.gz" "VCF_Results/truvari_out/hg2XM_FIN/tp-base.vcf.gz.tbi" "VCF_Results/truvari_out/hg2XM_FIN/tp-comp.vcf.gz" "VCF_Results/truvari_out/hg2XM_FIN/tp-comp.vcf.gz.tbi" "VCF_Results/truvari_out/hg2XM_FIN2/candidate.refine.bed" "VCF_Results/truvari_out/hg2XM_FIN2/fn.vcf.gz" "VCF_Results/truvari_out/hg2XM_FIN2/fn.vcf.gz.tbi" "VCF_Results/truvari_out/hg2XM_FIN2/fp.vcf.gz" "VCF_Results/truvari_out/hg2XM_FIN2/fp.vcf.gz.tbi" "VCF_Results/truvari_out/hg2XM_FIN2/log.txt" "VCF_Results/truvari_out/hg2XM_FIN2/params.json" "VCF_Results/truvari_out/hg2XM_FIN2/summary.json" "VCF_Results/truvari_out/hg2XM_FIN2/tp-base.vcf.gz" "VCF_Results/truvari_out/hg2XM_FIN2/tp-base.vcf.gz.tbi" "VCF_Results/truvari_out/hg2XM_FIN2/tp-comp.vcf.gz" "VCF_Results/truvari_out/hg2XM_FIN2/tp-comp.vcf.gz.tbi" "VCF_Results/truvari_out/hg2XM_FIN2_bed/candidate.refine.bed" "VCF_Results/truvari_out/hg2XM_FIN2_bed/fn.vcf.gz" "VCF_Results/truvari_out/hg2XM_FIN2_bed/fn.vcf.gz.tbi" "VCF_Results/truvari_out/hg2XM_FIN2_bed/fp.vcf.gz" "VCF_Results/truvari_out/hg2XM_FIN2_bed/fp.vcf.gz.tbi" "VCF_Results/truvari_out/hg2XM_FIN2_bed/log.txt" "VCF_Results/truvari_out/hg2XM_FIN2_bed/params.json" "VCF_Results/truvari_out/hg2XM_FIN2_bed/summary.json" "VCF_Results/truvari_out/hg2XM_FIN2_bed/tp-base.vcf.gz" "VCF_Results/truvari_out/hg2XM_FIN2_bed/tp-base.vcf.gz.tbi" "VCF_Results/truvari_out/hg2XM_FIN2_bed/tp-comp.vcf.gz" "VCF_Results/truvari_out/hg2XM_FIN2_bed/tp-comp.vcf.gz.tbi")



# Add each file in the list to the repository
for file in "${file_list[@]}"; do
    git add "$file"
done

