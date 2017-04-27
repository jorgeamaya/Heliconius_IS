#!/bin/bash

#Purpose: Master script to merge, sort and remove duplicates
#Written by: Jorge Eduardo Amaya Romero
#Date: 3/6/2017

#SBATCH -p serial_requeue,general
#SBATCH -J dict
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 0-0:30
#SBATCH --mem 40000
#SBATCH -o dict%j.out
#SBATCH -e dict%j.err

#Sort the bam file
source new-modules.sh;  module load samtools/1.4-fasrc01; module load picard/2.9.0-fasrc01
export PICARD_HOME='/n/sw/fasrcsw/apps/Core/picard/2.9.0-fasrc01'

java -Xmx40g -jar $PICARD_HOME/picard.jar CreateSequenceDictionary \
	R=Data/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa \
	O=Data/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.dict

samtools faidx Data/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa

