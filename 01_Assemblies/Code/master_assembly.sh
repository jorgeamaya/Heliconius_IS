#!/bin/bash

#Purpose: Assemble genomes with Stampy
#Written by: Jorge Eduardo Amaya Romero
#Date: 4/18/2017

#SBATCH -p general
#SBATCH -J assembly
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 1-00:00
#SBATCH --mem 40000
#SBATCH -o assembly%j.out
#SBATCH -e assembly%j.err

index_id=Results/Hmel2_sta
clean_reference=Results/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa #See master
#Build the indexes
#jobid_stampy_index=`sbatch Code/index_stampy.sh Results/Hmel2_sta Results/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa | cut -d ' ' -f 4` 
jobid_stampy_index=`sbatch Code/index_stampy.sh $index_id $clean_reference | cut -d ' ' -f 4` 

#Make the new assemblies
mkdir Results/Assemblies_Stampy

fix=100
for dir in /n/mallet_lab/edelman/elevatus_pardalinus/kanchon_resequence/HEL_*; do
	echo $dir
	for f in $dir/*; do
    		r="${f/1.fastq.gz/2.fastq.gz}"	
		n="${f/.R1.fastq.gz/}"
		echo "  f: $f"
    		echo "  r: $r"
		echo "  n: ${n##*/}" 

		for i in `seq 1 1 $fix`;
			do
			echo $i
			sbatch  Code/subordinate_assembly_stampy.sh $f $r ${n##*/} $i $fix $index_id
			done
		done
	done
