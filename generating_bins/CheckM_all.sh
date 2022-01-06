#!/bin/bash -l
#SBATCH -J BinningCheckM_All
#SBATCH -t 48:00:00
#SBATCH --mem 64000

module load bio 

module load pplacer 
rm -r BINS_COMBINED/checkm_lineage
checkm lineage_wf --reduced_tree -x fa BINS_COMBINED/ BINS_COMBINED/checkm_lineage
