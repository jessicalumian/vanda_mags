#!/bin/bash -l
#SBATCH -J MP8IB2
#SBATCH -t 48:00:00
#SBATCH --mem 32000

module load bio
module load pplacer
module load metabat/2.12.1
module load samtools
module load megahit

mkdir MP8IB2

megahit --12 RAWDATA/MP8IB2.fastq.gz  --min-contig-len 1500 -o MP8IB2/ASSEMBLY

mkdir MP8IB2/MAPPING

bowtie2-build MP8IB2/ASSEMBLY/final.contigs.fa MP8IB2/MAPPING/contigs


bowtie2 --threads 32 -x MP8IB2/MAPPING/contigs --interleaved RAWDATA/MP8IB2.fastq.gz -S MP8IB2/MAPPING/Sample_01.sam
samtools view -F 4 -bS MP8IB2/MAPPING/Sample_01.sam > MP8IB2/MAPPING/Sample_01-RAW.bam
anvi-init-bam MP8IB2/MAPPING/Sample_01-RAW.bam -o MP8IB2/MAPPING/Sample_01.bam
rm MP8IB2/MAPPING/Sample_01.sam MP8IB2/MAPPING/Sample_01-RAW.bam



jgi_summarize_bam_contig_depths --outputDepth MP8IB2/BINNING/depth.txt MP8IB2/MAPPING/Sample_01.bam
metabat -i MP8IB2/ASSEMBLY/final.contigs.fa -a MP8IB2/BINNING/depth.txt -o MP8IB2/BINNING/MP8IB2



rm -r MP8IB2/checkm_lineage
checkm lineage_wf --reduced_tree -x fa MP8IB2/BINNING MP8IB2/checkm_lineage 
