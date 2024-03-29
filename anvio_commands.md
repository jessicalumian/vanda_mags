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

Get into anvi'o directory for this workflow
```text
mkdir /home/jemizzi/chapter_2/anvio_circadian
cd /home/jemizzi/chapter_2/anvio_circadian
```

#### Step 1: Obtain data and fix fasta files (def lines and removing contigs <1000 nts)
Put fasta files of MAGs of interested into a directory. In this case I'm using 4 novel Vanda MAGs, my Phormidium pseudopriestleyi MAG, other polar cyanobacteria MAGs, and a few other cyanos of interest.

```text
$ ls
BulkMat_35.fa
MP8IB2_15.fa
OtherMAGsHere.fa
```

anvi'o requires clean def lines, see [explanation here](https://merenlab.org/2016/06/22/anvio-tutorial-v2/#take-a-look-at-your-fasta-file). Clean up fastas before proceeding to avoid snarky error messages:

```text
for i in `ls *fa | awk 'BEGIN{FS=".fa"}{print $1}'` # all files in data directory must end in .fa
do
    anvi-script-reformat-fasta $i.fa -o $i-fixed.fa -l 1000 --simplify-names
    # overwrite contigs with fixed contigs
    mv $i-fixed.fa $i.fa
done
```
This command also removes sequences shorter than 1000 nucleotides because anvi'o developers think this is a good idea, it makes sense to me and I trust them.


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
I've found it easiest to create the `external-genomes.txt` file in excel and then convert it to a .txt file. Just be sure to follow the formatting in the example. For `BulkMat_35.fa` and `MP8IB2_15.fa`, the file would look like this:

```text
name		contigs_db_path
BulkMat_35	BulkMat_35.db
MP8IB2_15	MP8IB2_15.db
```
Also, file names can't contain periods. The file I made is here: [external-genomes.txt](https://github.com/jessicalumian/vanda_mags/blob/master/external-genomes-circadian.txt).

#### Step 3.5: Create Custom HMMs file.
Follow the instructions [here](https://merenlab.org/2016/05/21/archaeal-single-copy-genes/). Get HMMs by searching [eggNOG](http://eggnog5.embl.de/#/app/home). Put these into a directory. In my case, I will choose `circadian_HMMs`.

#### Step 4: Custom HMM search.
Refer anvio to custom HMM files.
```text
for i in `ls *fa | awk 'BEGIN{FS=".fa"}{print $1}'` # all files in data directory must end in .fa
do
    anvi-run-hmms -c $i.db -H circadian_HMMs/
done
```

Get hits.

```text
for i in `ls *fa | awk 'BEGIN{FS=".fa"}{print $1}'` # all files in data directory must end in .fa
do
    anvi-get-sequences-for-hmm-hits --external-genomes external-genomes.txt \
                                -o $i.concatenated-proteins.fa \
                                --hmm-source circadian_HMMs \
                                --return-best-hit \
                                --get-aa-sequences \
                                --concatenate
done
```

Out of date notes:
Step 4: Custom HMM search.	
Look at available sequences: (maybe get rid of this code chunk)
```
anvi-get-sequences-for-hmm-hits --external-genomes external-genomes.txt \
                                   --hmm-source Bacteria_71 \
                                   --list-available-gene-names
```

Run HMM search:
```
anvi-get-sequences-for-hmm-hits --external-genomes external-genomes.txt \
                                -o concatenated-proteins.fa \
                                --hmm-source circadian \
                                --return-best-hit \
                                --get-aa-sequences \
                                --concatenate
```
