#!/bin/bash -l
#SBATCH -J BulkAssembly
#SBATCH -t 48:00:00
#SBATCH --mem 32000

module load bio
module load pplacer
module load metabat/2.12.1
module load samtools
module load megahit

mkdir LV9

megahit --12 RAWDATA/LV9.fastq.gz  --min-contig-len 1500 -o LV9/ASSEMBLY

mkdir LV9/MAPPING

bowtie2-build LV9/ASSEMBLY/final.contigs.fa LV9/MAPPING/contigs


bowtie2 --threads 32 -x LV9/MAPPING/contigs --interleaved RAWDATA/LV9.fastq.gz -S LV9/MAPPING/Sample_01.sam
samtools view -F 4 -bS LV9/MAPPING/Sample_01.sam > LV9/MAPPING/Sample_01-RAW.bam
anvi-init-bam LV9/MAPPING/Sample_01-RAW.bam -o LV9/MAPPING/Sample_01.bam
rm LV9/MAPPING/Sample_01.sam LV9/MAPPING/Sample_01-RAW.bam



jgi_summarize_bam_contig_depths --outputDepth LV9/BINNING/depth.txt LV9/MAPPING/Sample_01.bam
metabat -i LV9/ASSEMBLY/final.contigs.fa -a LV9/BINNING/depth.txt -o LV9/BINNING/MP5G1



rm -r LV9/checkm_lineage
checkm lineage_wf --reduced_tree -x fa LV9/BINNING LV9/checkm_lineage 
