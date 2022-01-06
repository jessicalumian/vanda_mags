#!/bin/bash -l
#SBATCH -J MP6G1
#SBATCH -t 48:00:00
#SBATCH --mem 32000

module load bio
module load pplacer
module load metabat/2.12.1
module load samtools
module load megahit

mkdir MP6G1

megahit --12 RAWDATA/MPGG1.fastq.gz  --min-contig-len 1500 -o MP6G1/ASSEMBLY

mkdir MP6G1/MAPPING

bowtie2-build MP6G1/ASSEMBLY/final.contigs.fa MP6G1/MAPPING/contigs


bowtie2 --threads 32 -x MP6G1/MAPPING/contigs --interleaved RAWDATA/MPGG1.fastq.gz -S MP6G1/MAPPING/Sample_01.sam
samtools view -F 4 -bS MP6G1/MAPPING/Sample_01.sam > MP6G1/MAPPING/Sample_01-RAW.bam
anvi-init-bam MP6G1/MAPPING/Sample_01-RAW.bam -o MP6G1/MAPPING/Sample_01.bam
rm MP6G1/MAPPING/Sample_01.sam MP6G1/MAPPING/Sample_01-RAW.bam



jgi_summarize_bam_contig_depths --outputDepth MP6G1/BINNING/depth.txt MP6G1/MAPPING/Sample_01.bam
metabat -i MP6G1/ASSEMBLY/final.contigs.fa -a MP6G1/BINNING/depth.txt -o MP6G1/BINNING/MP6G1



rm -r MP6G1/checkm_lineage
checkm lineage_wf --reduced_tree -x fa MP6G1/BINNING MP6G1/checkm_lineage 
