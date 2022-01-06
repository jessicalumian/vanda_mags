#!/bin/bash -l
#SBATCH -J BulkAssembly
#SBATCH -t 48:00:00
#SBATCH --mem 32000

module load bio
module load pplacer
module load metabat/2.12.1
module load samtools
module load megahit

mkdir BulkMat

megahit --12 RAWDATA/BulkMat.fastq.gz  --min-contig-len 1500 -o BulkMat/ASSEMBLY

mkdir BulkMat/MAPPING

bowtie2-build BulkMat/ASSEMBLY/final.contigs.fa BulkMat/MAPPING/contigs


bowtie2 --threads 32 -x BulkMat/MAPPING/contigs --interleaved RAWDATA/BulkMat.fastq.gz -S BulkMat/MAPPING/Sample_01.sam
samtools view -F 4 -bS BulkMat/MAPPING/Sample_01.sam > BulkMat/MAPPING/Sample_01-RAW.bam
anvi-init-bam BulkMat/MAPPING/Sample_01-RAW.bam -o BulkMat/MAPPING/Sample_01.bam
rm BulkMat/MAPPING/Sample_01.sam BulkMat/MAPPING/Sample_01-RAW.bam



jgi_summarize_bam_contig_depths --outputDepth BulkMat/BINNING/depth.txt BulkMat/MAPPING/Sample_01.bam
metabat -i BulkMat/ASSEMBLY/final.contigs.fa -a BulkMat/BINNING/depth.txt -o BulkMat/BINNING/MP5G1



rm -r BulkMat/checkm_lineage
checkm lineage_wf --reduced_tree -x fa BulkMat/BINNING BulkMat/checkm_lineage 
