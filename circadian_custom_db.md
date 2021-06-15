
## Instructions to Run a Custom BLAST Database Search

#### Step 1: Obtain sequence of interest from NCBI, then make a custom blastdb

```
makeblastdb -in kaia_reference.fa -input_type fasta -title kaia_db -out kaia_db_out -dbtype prot
makeblastdb -in kaib_reference.fa -input_type fasta -title kaib_db -out kaib_db_out -dbtype prot
makeblastdb -in kaic_reference.fa -input_type fasta -title kaic_db -out kaic_db_out -dbtype prot
makeblastdb -in cika_reference.fa -input_type fasta -title cika_db -out cika_db_out -dbtype prot
makeblastdb -in sasa_reference.fa -input_type fasta -title sasa_db -out sasa_db_out -dbtype prot
makeblastdb -in rpaa_reference.fa -input_type fasta -title rpaa_db -out rpaa_db_out -dbtype prot
```

#### Step 2: Search for each MAG
I like to do this one by one to ensure my e value fits what I'm looking for (so I'm not getting hits that don't match the reference gene). This is possible because I'm working with a manageable number of genes and MAGs.

```
# search bin 2 from MEGAHIT (phormidium bin)

blastx -db kaia_db_out -query /Users/jessicamizzi/Documents/Work/research/chapter_2/data/Leptoplynga_BulkMat_35.fa -evalue 1e-5 -outfmt "6 sseqid qseqid evalue pident qseq" -out bulk/kaia_bulk_1e5.out
blastx -db kaib_db_out -query /Users/jessicamizzi/Documents/Work/research/chapter_2/data/Leptoplynga_BulkMat_35.fa -evalue 1e-5 -outfmt "6 sseqid qseqid evalue pident qseq" -out bulk/kaib_bulk_1e5.out
blastx -db kaic_db_out -query /Users/jessicamizzi/Documents/Work/research/chapter_2/data/Leptoplynga_BulkMat_35.fa -evalue 1e-5 -outfmt "6 sseqid qseqid evalue pident qseq" -out bulk/kaic_bulk_1e5.out
blastx -db cika_db_out -query /Users/jessicamizzi/Documents/Work/research/chapter_2/data/Leptoplynga_BulkMat_35.fa -evalue 1e-5 -outfmt "6 sseqid qseqid evalue pident qseq" -out bulk/cika_bulk_1e5.out
blastx -db sasa_db_out -query /Users/jessicamizzi/Documents/Work/research/chapter_2/data/Leptoplynga_BulkMat_35.fa -evalue 1e-5 -outfmt "6 sseqid qseqid evalue pident qseq" -out bulk/sasa_bulk_1e5.out
blastx -db rpaa_db_out -query /Users/jessicamizzi/Documents/Work/research/chapter_2/data/Leptoplynga_BulkMat_35.fa -evalue 1e-5 -outfmt "6 sseqid qseqid evalue pident qseq" -out bulk/rpaa_bulk_1e5.out

# need to loop this
blastx -db kaia_db_out -query /Users/jessicamizzi/Documents/Work/research/chapter_2/data/Microcoleus_MP8IB2_171.fa -evalue 1e-5 -outfmt "6 sseqid qseqid evalue pident qseq" -out bulk/kaia_micro_1e5.out
blastx -db kaib_db_out -query /Users/jessicamizzi/Documents/Work/research/chapter_2/data/Microcoleus_MP8IB2_171.fa -evalue 1e-5 -outfmt "6 sseqid qseqid evalue pident qseq" -out bulk/kaib_mirco_1e5.out
blastx -db kaic_db_out -query /Users/jessicamizzi/Documents/Work/research/chapter_2/data/Microcoleus_MP8IB2_171.fa -evalue 1e-5 -outfmt "6 sseqid qseqid evalue pident qseq" -out bulk/kaic_micro_1e5.out
blastx -db cika_db_out -query /Users/jessicamizzi/Documents/Work/research/chapter_2/data/Microcoleus_MP8IB2_171.fa -evalue 1e-5 -outfmt "6 sseqid qseqid evalue pident qseq" -out bulk/cika_micro_1e5.out
blastx -db sasa_db_out -query /Users/jessicamizzi/Documents/Work/research/chapter_2/data/Microcoleus_MP8IB2_171.fa -evalue 1e-5 -outfmt "6 sseqid qseqid evalue pident qseq" -out bulk/sasa_micro_1e5.out
blastx -db rpaa_db_out -query /Users/jessicamizzi/Documents/Work/research/chapter_2/data/Microcoleus_MP8IB2_171.fa -evalue 1e-5 -outfmt "6 sseqid qseqid evalue pident qseq" -out bulk/rpaa_micro_1e5.out
```

## Old Information

1. Run command line blast, but output is only amino acids
2. New script that creates file:
	line 1: filename (basename to remove acpa and ending for sequence names)
	line 2: amino acids

# example:
>APphormidesmispriestleyiANA
>MSIVTKSIVNADAEARYLSPGELDRIKSFVTSGERRVRIAQVLTESRERIVKTAGDQLFQKRPDVVSPGGNAYGEEMTATCLRDMDYYLRLITYGVVAGDVTPIEEIGLVGAREMYNSLGTSIPAMADSIRCMKNVATGMMSGDEAAEAASYFDYVVGGLQ


# create custom blast db with gene of interest (in this case acpa)

makeblastdb -in /Users/jessicamizzi/Documents/Work/research/vanda_mags/phycobilisome_trees/reference_sequences/apca.fa -input_type fasta -title apcA_db -out apcA_db_out -dbtype prot

# for loop to search Vanda MAGs

for filename in /Users/jessicamizzi/Documents/Work/research/vanda_mags/mag_sequences/*.fa
do

        # use basename for easier file naming
        base=$(basename $filename .fa)
        echo $filename
        echo $base

        # blastx (custom blast db already made)
        blastx -db apcA_db_out -query ${filename} -evalue 1e-80 -outfmt "6 qseq" -out ${base}_1e-80_apca.out

done

# for loop for reference sequences
for filename in /Users/jessicamizzi/Documents/Work/research/vanda_mags/sequences/*.fa
do

        # use basename for easier file naming
        base=$(basename $filename .fa)
        echo $filename
        echo $base

        # blastx (custom blast db already made)
        blastx -db apcA_db_out -query ${filename} -evalue 1e-80 -outfmt "6 qseq" -out ${base}_1e-80_apca.out

done

## Script to make pre-alignment fasta for clustal

touch apca_prealign.fa

for filename in /Users/jessicamizzi/Documents/Work/research/vanda_mags/phycobilisome_trees/apca/*_apca.out
do
	# add filename to file
	base=$(basename $filename _1e-80_apca.out)
	echo $filename
	echo $base
	echo '>'${base} >> apca_prealign.fa 
	
	# add amino acid alignment as next line
	cat $filename >> apca_prealign.fa 
	
done

# Next use clustal to align, apca_prealign.fa, then RAxML to make a tree, the iTOL to view the tree.
