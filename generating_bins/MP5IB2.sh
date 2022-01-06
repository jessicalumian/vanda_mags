#!/bin/bash -l
#SBATCH -J BulkAssembly
#SBATCH -t 48:00:00
#SBATCH --mem 32000

module load bio
module load pplacer
module load metabat/2.12.1
module load samtools
module load megahit

mkdir MP5IB2

megahit --12 RAWDATA/MP5IB2.fastq.gz  --min-contig-len 1500 -o MP5IB2/ASSEMBLY

mkdir MP5IB2/MAPPING

bowtie2-build MP5IB2/ASSEMBLY/final.contigs.fa MP5IB2/MAPPING/contigs


bowtie2 --threads 32 -x MP5IB2/MAPPING/contigs --interleaved RAWDATA/MP5IB2.fastq.gz -S MP5IB2/MAPPING/Sample_01.sam
samtools view -F 4 -bS MP5IB2/MAPPING/Sample_01.sam > MP5IB2/MAPPING/Sample_01-RAW.bam
anvi-init-bam MP5IB2/MAPPING/Sample_01-RAW.bam -o MP5IB2/MAPPING/Sample_01.bam
rm MP5IB2/MAPPING/Sample_01.sam MP5IB2/MAPPING/Sample_01-RAW.bam



jgi_summarize_bam_contig_depths --outputDepth MP5IB2/BINNING/depth.txt MP5IB2/MAPPING/Sample_01.bam
metabat -i MP5IB2/ASSEMBLY/final.contigs.fa -a MP5IB2/BINNING/depth.txt -o MP5IB2/BINNING/MP5IB2



rm -r MP5IB2/checkm_lineage
checkm lineage_wf --reduced_tree -x fa MP5IB2/BINNING MP5IB2/checkm_lineage 
