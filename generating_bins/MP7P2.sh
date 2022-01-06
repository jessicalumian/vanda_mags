#!/bin/bash -l
#SBATCH -J MP7P2
#SBATCH -t 48:00:00
#SBATCH --mem 32000

module load bio
module load pplacer
module load metabat/2.12.1
module load samtools
module load megahit

mkdir MP7P2

megahit --12 RAWDATA/MP7P2.fastq.gz  --min-contig-len 1500 -o MP7P2/ASSEMBLY

mkdir MP7P2/MAPPING

bowtie2-build MP7P2/ASSEMBLY/final.contigs.fa MP7P2/MAPPING/contigs


bowtie2 --threads 32 -x MP7P2/MAPPING/contigs --interleaved RAWDATA/MP7P2.fastq.gz -S MP7P2/MAPPING/Sample_01.sam
samtools view -F 4 -bS MP7P2/MAPPING/Sample_01.sam > MP7P2/MAPPING/Sample_01-RAW.bam
anvi-init-bam MP7P2/MAPPING/Sample_01-RAW.bam -o MP7P2/MAPPING/Sample_01.bam
rm MP7P2/MAPPING/Sample_01.sam MP7P2/MAPPING/Sample_01-RAW.bam



jgi_summarize_bam_contig_depths --outputDepth MP7P2/BINNING/depth.txt MP7P2/MAPPING/Sample_01.bam
metabat -i MP7P2/ASSEMBLY/final.contigs.fa -a MP7P2/BINNING/depth.txt -o MP7P2/BINNING/MP7P2



rm -r MP7P2/checkm_lineage
checkm lineage_wf --reduced_tree -x fa MP7P2/BINNING MP7P2/checkm_lineage 
