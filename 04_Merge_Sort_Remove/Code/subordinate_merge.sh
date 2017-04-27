#!/bin/bash

#Purpose: Master script to merge files produces with stampy
#Written by: Jorge Eduardo Amaya Romero
#Date: 3/6/2017

#SBATCH -p serial_requeue,general
#SBATCH -J realign
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 0-2:00
#SBATCH --mem 100000
#SBATCH -o realign%j.out
#SBATCH -e realign%j.err

#Merge the bam file
source new-modules.sh; module load picard/2.9.0-fasrc01

export PICARD_HOME='/n/sw/fasrcsw/apps/Core/picard/2.9.0-fasrc01/'

mkdir /n/mallet_lab/jorge/Assemblies/Results/Assemblies_Stampy/Sample_Hel_15_20662_Hel_par_Ecu_TGACCA
#Remove duplicated reads
java -Xmx100g -jar $PICARD_HOME/picard.jar MergeSamFiles \
	I= ~/Heliconius_IS/Assemblies/Results/Assemblies_Stampy/Sample_Hel_15_20662_Hel_par_Ecu_TGACCA/Sample_Hel_15_20662_Hel_par_Ecu_TGACCA_400000.bam \
	I= ~/Heliconius_IS/Assemblies/Results/Assemblies_Stampy/Sample_Hel_15_20662_Hel_par_Ecu_TGACCA/Sample_Hel_15_20662_Hel_par_Ecu_TGACCA_800000.bam \
	O=/n/mallet_lab/jorge/Assemblies/Results/Assemblies_Stampy/Sample_Hel_15_20662_Hel_par_Ecu_TGACCA/Sample_Hel_15_20662_Hel_par_Ecu_TGACCA.bam

:<<'END'
combine_bam () {
	find $1 -name '*.bam' | {
	    read firstbam
	    samtools view -h "$firstbam"
 	    while read bam; do
        	samtools view "$bam"
   	    done
	} | samtools view -ubS -o $1_merged.bam
	#Index is optional
	#samtools index $1_merged.bam
}

combine_bam Sample_Hel_bam 
END
