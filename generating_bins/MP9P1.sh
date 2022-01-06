#!/bin/bash -l
#SBATCH -J MP9P1
#SBATCH -t 48:00:00
#SBATCH --mem 32000

module load bio
module load pplacer
module load metabat/2.12.1
module load samtools
module load megahit

mkdir MP9P1

megahit --12 RAWDATA/MP9P1.fastq.gz  --min-contig-len 1500 -o MP9P1/ASSEMBLY

mkdir MP9P1/MAPPING

bowtie2-build MP9P1/ASSEMBLY/final.contigs.fa MP9P1/MAPPING/contigs


bowtie2 --threads 32 -x MP9P1/MAPPING/contigs --interleaved RAWDATA/MP9P1.fastq.gz -S MP9P1/MAPPING/Sample_01.sam
samtools view -F 4 -bS MP9P1/MAPPING/Sample_01.sam > MP9P1/MAPPING/Sample_01-RAW.bam
anvi-init-bam MP9P1/MAPPING/Sample_01-RAW.bam -o MP9P1/MAPPING/Sample_01.bam
rm MP9P1/MAPPING/Sample_01.sam MP9P1/MAPPING/Sample_01-RAW.bam



jgi_summarize_bam_contig_depths --outputDepth MP9P1/BINNING/depth.txt MP9P1/MAPPING/Sample_01.bam
metabat -i MP9P1/ASSEMBLY/final.contigs.fa -a MP9P1/BINNING/depth.txt -o MP9P1/BINNING/MP9P1



rm -r MP9P1/checkm_lineage
checkm lineage_wf --reduced_tree -x fa MP9P1/BINNING MP9P1/checkm_lineage 
