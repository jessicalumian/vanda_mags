## anvi'o Phylogenomics Workflow with Custom hmms

I'm blatantly stealing the code from the [anvi'o Phylogenomics Workflow](https://merenlab.org/2017/06/07/phylogenomics/) and only including the steps that are relevant to my process for my own reference, and so I can write a SnakeMake file of this later. All code will be run in the directory of the input files, until I change this.

#### Step 0: Set up Peloton

Request an interactive session
```text
srun -p high -t 20:00:00 -u --pty bash -il
```

Load anvio module
```text
module load anvio/6.2-bio3
source activate anvio-6.2
```

#### Step 1: Obtain data
Put fasta files of MAGs of interested into a directory. In this case I'm using 4 novel Vanda MAGs, my Phormidium pseudopriestleyi MAG, other polar cyanobacteria MAGs, and a few other cyanos of interest.

```text
$ ls
BulkMat_35.fa
MP8IB2_15.fa
OtherMAGsHere.fa
```
#### Step 2: Generate anvi'o [contigs database](https://merenlab.org/software/anvio/help/main/artifacts/contigs-db/) for each fasta file.
anvi'o will make files that end in `.db` which contain information about the MAGs that will allow it to analyze the MAGs.

```text
for i in `ls *fa | awk 'BEGIN{FS=".fa"}{print $1}'` # all files in data directory must end in .fa
do
    anvi-gen-contigs-database -f $i.fa -o $i.db
    anvi-run-hmms -c $i.db
done
```

#### Step 3: Create `external-genomes.txt` file.

# Old code:
# Make database for all .fa files

for i in *fa
do
	anvi-script-FASTA-to-contigs-db $i
done

# Run Campbell db after downloading (from https://groups.google.com/g/anvio/c/wNf4H4X-R2A/m/iGY4itZjBwAJ)

for i in *db
do
	anvi-run-hmms -c $i -H /Users/jessicamizzi/anvio_vanda_mags/Campbell_et_al
done

# Pull Campbell genes

anvi-get-sequences-for-hmm-hits --external-genomes external-genomes.txt \
                                -o concatenated-proteins.fa \
                                --hmm-source Campbell_et_al \
                                --return-best-hit \
                                --get-aa-sequences \
                                --concatenate
