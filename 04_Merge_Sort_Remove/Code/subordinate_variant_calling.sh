#!/bin/bash

#Purpose: Master script to merge, sort and remove duplicates
#Written by: Jorge Eduardo Amaya Romero
#Date: 3/6/2017

#SBATCH -p serial_requeue,general
#SBATCH -J realign
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 0-12:00
#SBATCH --mem 40000
#SBATCH -o realign%j.out
#SBATCH -e realign%j.err

#Sort the bam file
mkdir Results/$1
source new-modules.sh; module load GATK/3.5-fasrc01

export GATK_HOME='/n/sw/fasrcsw/apps/Core/GenomeAnalysisTK/3.5-fasrc01/'
java -Xmx40g -jar $GATK_HOME/GenomeAnalysisTK.jar \
	-T UnifiedGenotyper \ #HaplotypeCaller
	-R Data/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa \
	-I Results/$1/$1_realigned.bam \ 
	-I Results/$2/$2_realigned.bam \ #Add more files later	
	-o Results/H_ele_par.vcf
