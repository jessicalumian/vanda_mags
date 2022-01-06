#!/bin/bash -l
#
#SBATCH --job-name=quast.sh
#SBATCH -t 02:00:00
#SBATCH --mem=4G
#SBATCH -o /home/jemizzi/chapter_2/output/quast/quast.out
#SBATCH -e /home/jemizzi/chapter_2/output/quast/quast.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

set -e

module load bio

# run quast on all genomes

for genome in /home/jemizzi/chapter_2/input/*.fa
do
    # grab genome name for output folder
    base=$(basename $genome .fa)

    quast.py  -o /home/jemizzi/chapter_2/output/quast/${base} ${genome}

done
