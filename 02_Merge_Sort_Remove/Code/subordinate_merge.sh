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
mkdir -p Results/$1

#Merge the files
java -Xmx100g -jar $PICARD_HOME/picard.jar MergeSamFiles \
	I=Data/$1/$1_1.bam \
	I=Data/$1/$1_2.bam \
	I=Data/$1/$1_3.bam \
	I=Data/$1/$1_4.bam \
	I=Data/$1/$1_5.bam \
	I=Data/$1/$1_6.bam \
	I=Data/$1/$1_7.bam \
	I=Data/$1/$1_8.bam \
	I=Data/$1/$1_9.bam \
	I=Data/$1/$1_10.bam \
	I=Data/$1/$1_11.bam \
	I=Data/$1/$1_12.bam \
	I=Data/$1/$1_13.bam \
	I=Data/$1/$1_14.bam \
	I=Data/$1/$1_15.bam \
	I=Data/$1/$1_16.bam \
	I=Data/$1/$1_17.bam \
	I=Data/$1/$1_18.bam \
	I=Data/$1/$1_19.bam \
	I=Data/$1/$1_20.bam \
	I=Data/$1/$1_21.bam \
	I=Data/$1/$1_22.bam \
	I=Data/$1/$1_23.bam \
	I=Data/$1/$1_24.bam \
	I=Data/$1/$1_25.bam \
	I=Data/$1/$1_26.bam \
	I=Data/$1/$1_27.bam \
	I=Data/$1/$1_28.bam \
	I=Data/$1/$1_29.bam \
	I=Data/$1/$1_30.bam \
	I=Data/$1/$1_31.bam \
	I=Data/$1/$1_32.bam \
	I=Data/$1/$1_33.bam \
	I=Data/$1/$1_34.bam \
	I=Data/$1/$1_35.bam \
	I=Data/$1/$1_36.bam \
	I=Data/$1/$1_37.bam \
	I=Data/$1/$1_38.bam \
	I=Data/$1/$1_39.bam \
	I=Data/$1/$1_40.bam \
	I=Data/$1/$1_41.bam \
	I=Data/$1/$1_42.bam \
	I=Data/$1/$1_43.bam \
	I=Data/$1/$1_44.bam \
	I=Data/$1/$1_45.bam \
	I=Data/$1/$1_46.bam \
	I=Data/$1/$1_47.bam \
	I=Data/$1/$1_48.bam \
	I=Data/$1/$1_49.bam \
	I=Data/$1/$1_50.bam \
	I=Data/$1/$1_51.bam \
	I=Data/$1/$1_52.bam \
	I=Data/$1/$1_53.bam \
	I=Data/$1/$1_54.bam \
	I=Data/$1/$1_55.bam \
	I=Data/$1/$1_56.bam \
	I=Data/$1/$1_57.bam \
	I=Data/$1/$1_58.bam \
	I=Data/$1/$1_59.bam \
	I=Data/$1/$1_60.bam \
	I=Data/$1/$1_61.bam \
	I=Data/$1/$1_62.bam \
	I=Data/$1/$1_63.bam \
	I=Data/$1/$1_64.bam \
	I=Data/$1/$1_65.bam \
	I=Data/$1/$1_66.bam \
	I=Data/$1/$1_67.bam \
	I=Data/$1/$1_68.bam \
	I=Data/$1/$1_69.bam \
	I=Data/$1/$1_70.bam \
	I=Data/$1/$1_71.bam \
	I=Data/$1/$1_72.bam \
	I=Data/$1/$1_73.bam \
	I=Data/$1/$1_74.bam \
	I=Data/$1/$1_75.bam \
	I=Data/$1/$1_76.bam \
	I=Data/$1/$1_77.bam \
	I=Data/$1/$1_78.bam \
	I=Data/$1/$1_79.bam \
	I=Data/$1/$1_80.bam \
	I=Data/$1/$1_81.bam \
	I=Data/$1/$1_82.bam \
	I=Data/$1/$1_83.bam \
	I=Data/$1/$1_84.bam \
	I=Data/$1/$1_85.bam \
	I=Data/$1/$1_86.bam \
	I=Data/$1/$1_87.bam \
	I=Data/$1/$1_88.bam \
	I=Data/$1/$1_89.bam \
	I=Data/$1/$1_90.bam \
	I=Data/$1/$1_91.bam \
	I=Data/$1/$1_92.bam \
	I=Data/$1/$1_93.bam \
	I=Data/$1/$1_94.bam \
	I=Data/$1/$1_95.bam \
	I=Data/$1/$1_96.bam \
	I=Data/$1/$1_97.bam \
	I=Data/$1/$1_98.bam \
	I=Data/$1/$1_99.bam \
	I=Data/$1/$1_100.bam \
	SORT_ORDER=coordinate \
	O=Results/$1/$1.bam

java -Xmx100g -jar $PICARD_HOME/picard.jar AddOrReplaceReadGroups \
	I=Results/$1/$1.bam \
	O=Results/$1/$1_sorted.bam \
	RGID=S1 \
	RGLB=library1 \
	RGPL=illumina \
	RGPU=HWI-ST1233.122 \
	RGSM=SAMPLE1 \
	SORT_ORDER=coordinate \
	CREATE_INDEX=true
	
