#!/bin/bash -l
#SBATCH -J BinningCheckM_All
#SBATCH -t 48:00:00
#SBATCH --mem 64000

module load bio3
source activate anvio3
module load metabat/2.12.1

metabat -i MP5G1/ASSEMBLY/final.contigs.fa -a MP5G1/BINNING/depth.txt -o MP5G1/BINNING/MP5G1
