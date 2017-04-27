#!/bin/bash

#Purpose: Master script to merge, sort and remove duplicates
#Written by: Jorge Eduardo Amaya Romero
#Date: 3/6/2017

#SBATCH -p serial_requeue,general
#SBATCH -J sort
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 0-12:00
#SBATCH --mem 100000
#SBATCH -o sort%j.out
#SBATCH -e sort%j.err

#Sort the bam file
#mkdir Results/$1
mkdir -p Results/Stampy/$1 #For stampy
source new-modules.sh;  module load picard/2.9.0-fasrc01

export PICARD_HOME='/n/sw/fasrcsw/apps/Core/picard/2.9.0-fasrc01/'

java -Xmx100g -jar $PICARD_HOME/picard.jar SortSam \
	I=/n/mallet_lab/jorge/Assemblies/Results/Assemblies_Stampy/$1/$1.bam \
	O=Results/Stampy/$1/$1.bam \
	SORT_ORDER=coordinate

	#I=/n/mallet_lab/jorge/Assemblies/Results/Assemblies_Bwa/$1/$1.bam \
	#Uncomment previous line for Stampy assemblies
	#O=Results/$1/$1.bam \
