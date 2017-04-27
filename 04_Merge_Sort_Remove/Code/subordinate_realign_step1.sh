#!/bin/bash

#Purpose: Master script to merge, sort and remove duplicates
#Written by: Jorge Eduardo Amaya Romero
#Date: 3/6/2017

#SBATCH -p serial_requeue,general
#SBATCH -J realign
#SBATCH -n 16
#SBATCH -N 1
#SBATCH -t 0-12:00
#SBATCH --mem 100000
#SBATCH -o realign%j.out
#SBATCH -e realign%j.err

#Realign the sam file
source new-modules.sh; module load GATK/3.5-fasrc01; module load samtools/1.4-fasrc01
export GATK_HOME='/n/sw/fasrcsw/apps/Core/GenomeAnalysisTK/3.5-fasrc01'

java -Xmx100g -jar $GATK_HOME/GenomeAnalysisTK.jar \
	-nt 16 \
	-T RealignerTargetCreator \
	-R Data/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa \
	-I Results/$1/$1_clean.bam \
	-o Results/$1/$1.intervals 
