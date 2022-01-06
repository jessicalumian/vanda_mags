#!/bin/bash -l
#SBATCH -J P2IB
#SBATCH -t 48:00:00
#SBATCH --mem 32000

module load bio
module load pplacer
module load metabat/2.12.1
module load samtools
module load megahit

mkdir P2IB

megahit --12 RAWDATA/P2IB.fastq.gz  --min-contig-len 1500 -o P2IB/ASSEMBLY

mkdir P2IB/MAPPING

bowtie2-build P2IB/ASSEMBLY/final.contigs.fa P2IB/MAPPING/contigs


bowtie2 --threads 32 -x P2IB/MAPPING/contigs --interleaved RAWDATA/P2IB.fastq.gz -S P2IB/MAPPING/Sample_01.sam
samtools view -F 4 -bS P2IB/MAPPING/Sample_01.sam > P2IB/MAPPING/Sample_01-RAW.bam
anvi-init-bam P2IB/MAPPING/Sample_01-RAW.bam -o P2IB/MAPPING/Sample_01.bam
rm P2IB/MAPPING/Sample_01.sam P2IB/MAPPING/Sample_01-RAW.bam



jgi_summarize_bam_contig_depths --outputDepth P2IB/BINNING/depth.txt P2IB/MAPPING/Sample_01.bam
metabat -i P2IB/ASSEMBLY/final.contigs.fa -a P2IB/BINNING/depth.txt -o P2IB/BINNING/P2IB



rm -r P2IB/checkm_lineage
checkm lineage_wf --reduced_tree -x fa P2IB/BINNING P2IB/checkm_lineage 
