#!/bin/bash -l
#SBATCH -J BulkAssembly
#SBATCH -t 48:00:00
#SBATCH --mem 32000

module load bio
module load pplacer
module load metabat/2.12.1
module load samtools
module load megahit

#mkdir MP6IB1

#megahit --12 RAWDATA/MP6IB1.fastq.gz  --min-contig-len 1500 -o MP6IB1/ASSEMBLY

#mkdir MP6IB1/MAPPING

#bowtie2-build MP6IB1/ASSEMBLY/final.contigs.fa MP6IB1/MAPPING/contigs


#bowtie2 --threads 32 -x MP6IB1/MAPPING/contigs --interleaved RAWDATA/MP6IB1.fastq.gz -S MP6IB1/MAPPING/Sample_01.sam
#samtools view -F 4 -bS MP6IB1/MAPPING/Sample_01.sam > MP6IB1/MAPPING/Sample_01-RAW.bam
#anvi-init-bam MP6IB1/MAPPING/Sample_01-RAW.bam -o MP6IB1/MAPPING/Sample_01.bam
#rm MP6IB1/MAPPING/Sample_01.sam MP6IB1/MAPPING/Sample_01-RAW.bam



#jgi_summarize_bam_contig_depths --outputDepth MP6IB1/BINNING/depth.txt MP6IB1/MAPPING/Sample_01.bam
metabat -i MP6IB1/ASSEMBLY/final.contigs.fa -a MP6IB1/BINNING/depth.txt -o MP6IB1/BINNING/MP6IB1



rm -r MP6IB1/checkm_lineage
checkm lineage_wf --reduced_tree -x fa MP6IB1/BINNING MP6IB1/checkm_lineage 
