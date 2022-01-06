#!/bin/bash -l
#SBATCH -J Binning
#SBATCH -t 48:00:00
#SBATCH --mem 32000



module load bio 

bowtie2 --threads 32 -x BulkMat/MAPPING/contigs --interleaved RAWDATA/BulkMat.fastq.gz -S BulkMat/MAPPING/Sample_01.sam
samtools view -F 4 -bS BulkMat/MAPPING/Sample_01.sam > BulkMat/MAPPING/Sample_01-RAW.bam

bowtie2 --threads 32 -x LV9/MAPPING/contigs --interleaved RAWDATA/LV9.fastq.gz -S LV9/MAPPING/Sample_01.sam
samtools view -F 4 -bS LV9/MAPPING/Sample_01.sam > LV9/MAPPING/Sample_01-RAW.bam

bowtie2 --threads 32 -x MP5G1/MAPPING/contigs --interleaved RAWDATA/MP5G1.fastq.gz -S MP5G1/MAPPING/Sample_01.sam
samtools view -F 4 -bS MP5G1/MAPPING/Sample_01.sam > MP5G1/MAPPING/Sample_01-RAW.bam


bowtie2 --threads 32 -x MP5IB2/MAPPING/contigs --interleaved RAWDATA/MP5IB2.fastq.gz -S MP5IB2/MAPPING/Sample_01.sam
samtools view -F 4 -bS MP5IB2/MAPPING/Sample_01.sam > MP5IB2/MAPPING/Sample_01-RAW.bam


bowtie2 --threads 32 -x MP6IB1/MAPPING/contigs --interleaved RAWDATA/MP6IB1.fastq.gz -S MP6IB1/MAPPING/Sample_01.sam
samtools view -F 4 -bS MP6IB1/MAPPING/Sample_01.sam > MP6IB1/MAPPING/Sample_01-RAW.bam

bowtie2 --threads 32 -x MP7G1/MAPPING/contigs --interleaved RAWDATA/MP7G1.fastq.gz -S MP7G1/MAPPING/Sample_01.sam
samtools view -F 4 -bS MP7G1/MAPPING/Sample_01.sam > MP7G1/MAPPING/Sample_01-RAW.bam

bowtie2 --threads 32 -x MP7P2/MAPPING/contigs --interleaved RAWDATA/MP7P2.fastq.gz -S MP7P2/MAPPING/Sample_01.sam
samtools view -F 4 -bS MP7P2/MAPPING/Sample_01.sam > MP7P2/MAPPING/Sample_01-RAW.bam


bowtie2 --threads 32 -x MP8IB2/MAPPING/contigs --interleaved RAWDATA/MP8IB2.fastq.gz -S MP8IB2/MAPPING/Sample_01.sam
samtools view -F 4 -bS MP8IB2/MAPPING/Sample_01.sam > MP8IB2/MAPPING/Sample_01-RAW.bam

bowtie2 --threads 32 -x MP9P1/MAPPING/contigs --interleaved RAWDATA/MP9P1.fastq.gz -S MP9P1/MAPPING/Sample_01.sam
samtools view -F 4 -bS MP9P1/MAPPING/Sample_01.sam > MP9P1/MAPPING/Sample_01-RAW.bam

bowtie2 --threads 32 -x P2IB/MAPPING/contigs --interleaved RAWDATA/P2IB.fastq.gz -S P2IB/MAPPING/Sample_01.sam
samtools view -F 4 -bS P2IB/MAPPING/Sample_01.sam > P2IB/MAPPING/Sample_01-RAW.bam

bowtie2 --threads 32 -x SP4G1/MAPPING/contigs --interleaved RAWDATA/SP4G1.fastq.gz -S SP4G1/MAPPING/Sample_01.sam
samtools view -F 4 -bS SP4G1/MAPPING/Sample_01.sam > SP4G1/MAPPING/Sample_01-RAW.bam

bowtie2 --threads 32 -x MP6G1/MAPPING/contigs --interleaved RAWDATA/MP6G1.fastq.gz -S MP6G1/MAPPING/Sample_01.sam
samtools view -F 4 -bS MP6G1/MAPPING/Sample_01.sam > MP6G1/MAPPING/Sample_01-RAW.bam




module load bio3
source activate anvio3

anvi-init-bam BulkMat/MAPPING/Sample_01-RAW.bam -o BulkMat/MAPPING/Sample_01.bam
jgi_summarize_bam_contig_depths --outputDepth BulkMat/BINNING/depth.txt BulkMat/MAPPING/Sample_01.bam


anvi-init-bam LV9/MAPPING/Sample_01-RAW.bam -o LV9/MAPPING/Sample_01.bam
jgi_summarize_bam_contig_depths --outputDepth LV9/BINNING/depth.txt LV9/MAPPING/Sample_01.bam


anvi-init-bam MP5G1/MAPPING/Sample_01-RAW.bam -o MP5G1/MAPPING/Sample_01.bam
jgi_summarize_bam_contig_depths --outputDepth MP5G1/BINNING/depth.txt MP5G1/MAPPING/Sample_01.bam


anvi-init-bam MP5IB2/MAPPING/Sample_01-RAW.bam -o MP5IB2/MAPPING/Sample_01.bam
jgi_summarize_bam_contig_depths --outputDepth MP5IB2/BINNING/depth.txt MP5IB2/MAPPING/Sample_01.bam


anvi-init-bam MP6IB1/MAPPING/Sample_01-RAW.bam -o MP6IB1/MAPPING/Sample_01.bam
jgi_summarize_bam_contig_depths --outputDepth MP6IB1/BINNING/depth.txt MP6IB1/MAPPING/Sample_01.bam


anvi-init-bam MP7G1/MAPPING/Sample_01-RAW.bam -o MP7G1/MAPPING/Sample_01.bam
jgi_summarize_bam_contig_depths --outputDepth MP7G1/BINNING/depth.txt MP7G1/MAPPING/Sample_01.bam


anvi-init-bam MP7P2/MAPPING/Sample_01-RAW.bam -o MP7P2/MAPPING/Sample_01.bam
jgi_summarize_bam_contig_depths --outputDepth MP7P2/BINNING/depth.txt MP7P2/MAPPING/Sample_01.bam


anvi-init-bam MP8IB2/MAPPING/Sample_01-RAW.bam -o MP8IB2/MAPPING/Sample_01.bam
jgi_summarize_bam_contig_depths --outputDepth MP8IB2/BINNING/depth.txt MP8IB2/MAPPING/Sample_01.bam


anvi-init-bam MP9P1/MAPPING/Sample_01-RAW.bam -o MP9P1/MAPPING/Sample_01.bam
jgi_summarize_bam_contig_depths --outputDepth MP9P1/BINNING/depth.txt MP9P1/MAPPING/Sample_01.bam


anvi-init-bam P2IB/MAPPING/Sample_01-RAW.bam -o P2IB/MAPPING/Sample_01.bam
jgi_summarize_bam_contig_depths --outputDepth P2IB/BINNING/depth.txt P2IB/MAPPING/Sample_01.bam

anvi-init-bam SP4G1/MAPPING/Sample_01-RAW.bam -o SP4G1/MAPPING/Sample_01.bam
jgi_summarize_bam_contig_depths --outputDepth SP4G1/BINNING/depth.txt SP4G1/MAPPING/Sample_01.bam

anvi-init-bam MP6G1/MAPPING/Sample_01-RAW.bam -o MP6G1/MAPPING/Sample_01.bam
jgi_summarize_bam_contig_depths --outputDepth MP6G1/BINNING/depth.txt MP6G1/MAPPING/Sample_01.bam


module load metabat

metabat -i BulkMat/ASSEMBLY/final.contigs.fa -a BulkMat/BINNING/depth.txt -o BulkMat/BINNING/BulkMat
metabat -i LV9/ASSEMBLY/final.contigs.fa -a LV9/BINNING/depth.txt -o LV9/BINNING/LV9
metabat -i MP5G1/ASSEMBLY/final.contigs.fa -a MP5G1/BINNING/depth.txt -o MP5G1/BINNING/MP5G1metabat -i MP5G1/ASSEMBLY/final.contigs.fa -a MP5G1/BINNING/depth.txt -o MP5G1/BINNING/MP5G1
metabat -i MP5IB2/ASSEMBLY/final.contigs.fa -a MP5IB2/BINNING/depth.txt -o MP5IB2/BINNING/MP5IB2
metabat -i MP6IB1/ASSEMBLY/final.contigs.fa -a MP6IB1/BINNING/depth.txt -o MP6IB1/BINNING/MP6IB1
metabat -i MP7G1/ASSEMBLY/final.contigs.fa -a MP7G1/BINNING/depth.txt -o MP7G1/BINNING/MP7G1
metabat -i MP7P2/ASSEMBLY/final.contigs.fa -a MP7P2/BINNING/depth.txt -o MP7P2/BINNING/MP7P2
metabat -i MP8IB2/ASSEMBLY/final.contigs.fa -a MP8IB2/BINNING/depth.txt -o MP8IB2/BINNING/MP8IB2
metabat -i MP9P1/ASSEMBLY/final.contigs.fa -a MP9P1/BINNING/depth.txt -o MP9P1/BINNING/MP9P1
metabat -i P2IB/ASSEMBLY/final.contigs.fa -a P2IB/BINNING/depth.txt -o P2IB/BINNING/P2IB
metabat -i SP4G1/ASSEMBLY/final.contigs.fa -a SP4G1/BINNING/depth.txt -o SP4G1/BINNING/SP4G1
metabat -i MP6G1/ASSEMBLY/final.contigs.fa -a MP6G1/BINNING/depth.txt -o MP6G1/BINNING/MP6G1



module load pplacer 

scp BulkMat/BINNING/*.fa BINS_COMBINED
scp LV9/BINNING/*.fa BINS_COMBINED
scp MP5G1/BINNING/*.fa BINS_COMBINED
scp MP5IB2/BINNING/*.fa BINS_COMBINED
scp MP6IB1/BINNING/*.fa BINS_COMBINED
scp MP7G1/BINNING/*.fa BINS_COMBINED
scp MP7P2/BINNING/*.fa BINS_COMBINED
scp MP8IB2/BINNING/*.fa BINS_COMBINED
scp MP9P1/BINNING/*.fa BINS_COMBINED
scp P2IB/BINNING/*.fa BINS_COMBINED
scp SP4G1/BINNING/*.fa BINS_COMBINED
scp MP6G1/BINNING/*.fa BINS_COMBINED

rm -r BINS_COMBINED/checkm_lineage
checkm lineage_wf --reduced_tree -x fa BINS_COMBINED/ BINS_COMBINED/checkm_lineage
