#!/bin/bash

#Purpose: Master script to merge, sort and remove duplicates
#Written by: Jorge Eduardo Amaya Romero
#Date: 3/6/2017

#SBATCH -p serial_requeue,general
#SBATCH -J realign
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 0-2:00
#SBATCH --mem 40000
#SBATCH -o realign%j.out
#SBATCH -e realign%j.err

#Sort the bam file
source new-modules.sh;  module load samtools/1.4-fasrc01; module load picard/2.9.0-fasrc01
export PICARD_HOME='/n/sw/fasrcsw/apps/Core/picard/2.9.0-fasrc01'

java -Xmx40g -jar $PICARD_HOME/picard.jar CreateSequenceDictionary \
	R=Data/$1.fa \
	O=Data/$2.fa

#	R=Data/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa \
#	O=Data/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.dict

#samtools faidx Data/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa
samtools faidx Data/$1.fa 
