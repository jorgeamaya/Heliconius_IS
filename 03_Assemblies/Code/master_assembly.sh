#!/bin/bash

#Purpose: Assemble genomes with Stampy
#Written by: Jorge Eduardo Amaya Romero
#Date: 4/18/2017

#SBATCH -p general
#SBATCH -J assembly
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 0-0:20
#SBATCH --mem 100
#SBATCH -o assembly%j.out
#SBATCH -e assembly%j.err

reference=Results/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa #See master
#Build the indexes
#jobid_bwa_index=`sbatch Code/index_bwa.sh Results/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa Results/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa | cut -d ' ' -f 4`
jobid_bwa_index=`sbatch Code/index_bwa.sh Results/$reference Results/$reference | cut -d ' ' -f 4` 

#Make the new assemblies
mkdir Results/Assemblies_Bwa

for dir in /n/mallet_lab/edelman/elevatus_pardalinus/kanchon_resequence/HEL_*; do
	echo $dir
	for f in $dir/*\1.fastq.gz; do
    		r="${f/1.fastq.gz/2.fastq.gz}"	
		n="${f/.R1.fastq.gz/}"
		echo "  f: $f"
    		echo "  r: $r"
		echo "  n: ${n##*/}" 
		#sbatch  Code/subordinate_assembly_bwa.sh $f $r ${n##*/} Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa
		sbatch  Code/subordinate_assembly_bwa.sh $f $r ${n##*/} $reference
		done
	done
