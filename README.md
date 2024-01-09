# Research Internship at LUMC - SASC scripts

## by Leonard Tiling

The following gives a structure for the scripts I used in the internship. They are designed for automatic multiple and consistent execution of task of my workflow. 

First, the slurm scripts I used to start the compute intensive tasks on the LUMC HPC are listed. *run_SVision.sh* and *run_MAMnet.sh* contain all the optional slurm parameter and the commands for different genome, genome settings and tool specific parameter choices.
Everything will be documented in an output log of slurm and the tools. 

Next, *Preprocess SVision for truvari use* modifies the output vcf of SVision in a way, that truvari can handle the file format. It excludes certain CSVs for comparison reasons and sorts, annotates and indexes the vcf file for truvari.

Finally, *Preprocess MAMnet for truvari use* addresses the same functions for MAMnet, so that the output file can be compared with SVision using truvari. 


More used code is listed for interest. 
