#!/bin/bash -l
#
#SBATCH --job-name=prokka.sh
#SBATCH -t 04:00:00
#SBATCH --mem=4G
#SBATCH -o /home/jemizzi/chapter_2/output/prokka.out
#SBATCH -e /home/jemizzi/chapter_2/output/prokka.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

set -e

module load bio

# run prokka on all genomes

for genome in /home/jemizzi/chapter_2/input/*.fa
do
    # grab genome name for output folder
    base=$(basename $genome .fa)

    prokka --outdir /home/jemizzi/chapter_2/output/prokka/${base} --prefix ${base} ${genome}

done
