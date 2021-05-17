
## Instructions to Run a Custom BLAST Database Search

#### Step 1: Obtain sequence of interest from NCBI, then make a custom blastdb

makeblastdb -in reference.fa -input_type fasta -title output_db -out output_db_out -dbtype prot


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
