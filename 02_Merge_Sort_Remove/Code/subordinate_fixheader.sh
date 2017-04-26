#!/bin/bash

#Purpose: Master script to merge files produces with stampy
#Written by: Jorge Eduardo Amaya Romero
#Date: 3/6/2017

#SBATCH -p serial_requeue,general
#SBATCH -J realign
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 1-0:00
#SBATCH --mem 100000
#SBATCH -o realign%j.out
#SBATCH -e realign%j.err

#Merge the bam file
source new-modules.sh; module load picard/2.9.0-fasrc01

export PICARD_HOME='/n/sw/fasrcsw/apps/Core/picard/2.9.0-fasrc01/'

java -Xmx100g -jar $PICARD_HOME/picard.jar AddOrReplaceReadGroups \
	I=Results/$1/$1.bam \
	O=Results/$1/$1_sorted.bam \
	RGID=S1 \
	RGLB=library1 \
	RGPL=illumina \
	RGPU=HWI \
	RGSM=SAMPLE1 \
	SORT_ORDER=coordinate \
	CREATE_INDEX=true
	
#	RGPU=HWI-ST1233.122 \
