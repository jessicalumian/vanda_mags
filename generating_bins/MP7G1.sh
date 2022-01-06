#!/bin/bash -l
#SBATCH -J BulkAssembly
#SBATCH -t 48:00:00
#SBATCH --mem 32000

module load bio
module load pplacer
module load metabat/2.12.1
module load samtools
module load megahit

mkdir MP7G1

megahit --12 RAWDATA/MP7G1.fastq.gz  --min-contig-len 1500 -o MP7G1/ASSEMBLY

mkdir MP7G1/MAPPING

bowtie2-build MP7G1/ASSEMBLY/final.contigs.fa MP7G1/MAPPING/contigs


bowtie2 --threads 32 -x MP7G1/MAPPING/contigs --interleaved RAWDATA/MP7G1.fastq.gz -S MP7G1/MAPPING/Sample_01.sam
samtools view -F 4 -bS MP7G1/MAPPING/Sample_01.sam > MP7G1/MAPPING/Sample_01-RAW.bam
anvi-init-bam MP7G1/MAPPING/Sample_01-RAW.bam -o MP7G1/MAPPING/Sample_01.bam
rm MP7G1/MAPPING/Sample_01.sam MP7G1/MAPPING/Sample_01-RAW.bam



jgi_summarize_bam_contig_depths --outputDepth MP7G1/BINNING/depth.txt MP7G1/MAPPING/Sample_01.bam
metabat -i MP7G1/ASSEMBLY/final.contigs.fa -a MP7G1/BINNING/depth.txt -o MP7G1/BINNING/MP7G1



rm -r MP7G1/checkm_lineage
checkm lineage_wf --reduced_tree -x fa MP7G1/BINNING MP7G1/checkm_lineage 
