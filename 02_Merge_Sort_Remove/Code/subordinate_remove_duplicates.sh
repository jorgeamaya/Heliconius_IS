#!/bin/bash

#Purpose: Master script to merge, sort and remove duplicates
#Written by: Jorge Eduardo Amaya Romero
#Date: 3/6/2017

#SBATCH -p serial_requeue,general
#SBATCH -J rem_dup
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 1-0:00
#SBATCH --mem 100000
#SBATCH -o rem_dup%j.out
#SBATCH -e rem_dup%j.err

source new-modules.sh; module load picard/2.9.0-fasrc01
export PICARD_HOME='/n/sw/fasrcsw/apps/Core/picard/2.9.0-fasrc01/'

#Remove duplicated reads
java -Xmx100g -jar $PICARD_HOME/picard.jar MarkDuplicates \
	ASSUME_SORT_ORDER=coordinate \
	I=Results/$1/$1_sorted.bam \
	O=Results/$1/$1_clean.bam \
	M=Results/$1/$1_metrics.txt \
	CREATE_INDEX=true
