#!/bin/bash

#Purpose: Master script to merge, sort and remove duplicates
#Written by: Jorge Eduardo Amaya Romero
#Date: 3/6/2017

#SBATCH -p general
#SBATCH -J master
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 0-1:00
#SBATCH --mem 40000
#SBATCH -o master%j.out
#SBATCH -e master%j.err

#Link the alignments 
ln -s ~/Heliconius_IS/Data/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa Data/.
ln -s ~/03_Assemblies/Results/Assemblies_Bwa/* Data/.

#Create the dictionary
sbatch subordinate_make_dict.sh 

#For files produced with bwa, the merge step can be skipped.
#Sort the alignment
#duplica=`sbatch Code/subordinate_remove_duplicates.sh Sample_Hel_15_20662_Hel_par_Ecu_TGACCA | cut -d ' ' -f 4`
#realig1=`sbatch --dependency=afterok:$duplica Code/subordinate_realign_step1.sh Sample_Hel_15_20662_Hel_par_Ecu_TGACCA | cut -d ' ' -f 4`
#realig2=`sbatch --dependency=afterok:$realig1 Code/subordinate_realign_step2.sh Sample_Hel_15_20662_Hel_par_Ecu_TGACCA | cut -d ' ' -f 4`
#sbatch --dependency=afterok:$realig2 Code/subordinate_call_variant.sh Sample_Hel_15_20662_Hel_par_Ecu_TGACCA #Call variant with HaplotypeCaller
#sbatch --dependency=afterok:$realig2 Code/subordinate_call_variant2.sh Sample_Hel_15_20662_Hel_par_Ecu_TGACCA #Call variant with UnifiedGenotyper

for dir in Data/Sample*; do
                dir=${dir##*/}
                duplica=`sbatch Code/subordinate_remove_duplicates.sh $dir | cut -d ' ' -f 4`
                realig1=`sbatch --dependency=afterok:$duplica Code/subordinate_realign_step1.sh $dir | cut -d ' ' -f 4`
                realig2=`sbatch --dependency=afterok:$realig1 Code/subordinate_realign_step2.sh $dir | cut -d ' ' -f 4`
                sbatch --dependency=afterok:$realig2 Code/subordinate_call_variant.sh $dir #Call variant with HaplotypeCaller
                sbatch --dependency=afterok:$realig2 Code/subordinate_call_variant2.sh $dir #Call variant with UnifiedGenotyper 
        done
