#!/bin/bash -l
#SBATCH -J SP4G1
#SBATCH -t 48:00:00
#SBATCH --mem 32000

module load bio
module load pplacer
module load metabat/2.12.1
module load samtools
module load megahit

mkdir SP4G1

megahit --12 RAWDATA/SP4G1.fastq.gz  --min-contig-len 1500 -o SP4G1/ASSEMBLY

mkdir SP4G1/MAPPING

bowtie2-build SP4G1/ASSEMBLY/final.contigs.fa SP4G1/MAPPING/contigs


bowtie2 --threads 32 -x SP4G1/MAPPING/contigs --interleaved RAWDATA/SP4G1.fastq.gz -S SP4G1/MAPPING/Sample_01.sam
samtools view -F 4 -bS SP4G1/MAPPING/Sample_01.sam > SP4G1/MAPPING/Sample_01-RAW.bam
anvi-init-bam SP4G1/MAPPING/Sample_01-RAW.bam -o SP4G1/MAPPING/Sample_01.bam
rm SP4G1/MAPPING/Sample_01.sam SP4G1/MAPPING/Sample_01-RAW.bam



jgi_summarize_bam_contig_depths --outputDepth SP4G1/BINNING/depth.txt SP4G1/MAPPING/Sample_01.bam
metabat -i SP4G1/ASSEMBLY/final.contigs.fa -a SP4G1/BINNING/depth.txt -o SP4G1/BINNING/SP4G1



rm -r SP4G1/checkm_lineage
checkm lineage_wf --reduced_tree -x fa SP4G1/BINNING SP4G1/checkm_lineage 
