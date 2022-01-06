#!/bin/bash -l
#SBATCH -J Binning
#SBATCH -t 48:00:00
#SBATCH --mem 32000

module load bio
module load pplacer

rm -r BINS_COMBINED/checkm_lineage
checkm lineage_wf --reduced_tree -x fa BINS_COMBINED/ BINS_COMBINED/checkm_lineage
