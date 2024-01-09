# Research Project at LUMC - SASC scripts

## by Leonard Tiling

Below you will find information about the scripts I used as part of the research project. They are designed for automatic, multiple and consistent execution of the tasks in my workflow. 


### Executing the SVision and MAMnet on the HPC cluster
The slurm scripts I used to start the compute intensive tasks on the LUMC HPC are listed in the folder *Report_files/slurm_scripts*.
The script for SVision is *run_SVision.sh* and for MAMnet *run_MAMnet.sh*. They contain all the optional slurm parameter and the commands for different genome, genome settings and tool specific parameter choices.
Everything will be documented in an output log of slurm and the tools. 

The script *filter_bam.slurm* creates a slurm job on the cluster that uses samtools to filter out all secondary alignments, using the bam file flag 256. This filtered bam file was used for MAMnet before the sourcecode of MAMnet was adapted. 

### Result file processing for truvari
Next, the folder *truvari_processing* contains two bash scripts including awk programing language modify the output vcf of SVision and MAMnet so that truvari can handle the comparison of them. 
For SVision it excludes certain CSVs for comparison reasons and for MAMnet it adds placeholder information so that truvari can read the file. For both, sorting, annotating indexing and cleanup of intermediat files happens automatically.

*process_bamfile.sh* was used to only include chromosome 1 to M for experimental reasons. 

### Additional material

More scripts, output files and logs are uploaded here.  
