#!/bin/bash

#Purpose: Assemble genomes with Stampy
#Written by: Jorge Eduardo Amaya Romero
#Date: 4/18/2017

#SBATCH -p serial_requeue
#SBATCH -J sta_assemble
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 0-12:00
#SBATCH --mem 1000
#SBATCH -o sta_assemble%j.out
#SBATCH -e sta_assemble%j.err

source new-modules.sh; module load stampy/1.0.31-fasrc01; module load samtools/1.4-fasrc01;
cd Results
mkdir -p Assemblies_Stampy/$3

#Create a partition in scratch to prevent clogging the home directory
start_dir=$PWD
mkdir -p /scratch/$USER/$SLURM_JOBID
#Copy the bwa index to scratch
cp Hmel* /scratch/$USER/$SLURM_JOBID/.
#Jump to the partition
cd /scratch/$USER/$SLURM_JOBID
cp $1 .
cp $2 .

#Assemble!
#echo "stampy.py -g Hmel2_sta -h Hmel2_sta --insertsize=500 --insertsd=100 --substitutionrate=0.01 --processpart="$4/$5" --output=$3_$4.sam -M $1 $2"
#stampy.py -g Hmel2_sta -h Hmel2_sta --insertsize=500 --insertsd=100 --substitutionrate=0.01 --processpart="$4/$5" --output=$3_$4.sam --verbosity=2 -M $1 $2

stampy.py -g $5 -h $5 --insertsize=500 --insertsd=100 --substitutionrate=0.01 --processpart="$4/$5" --output=$3_$4.sam --verbosity=2 -M $1 $2
samtools view -bS $3_$4.sam -o $start_dir/Assemblies_Stampy/$3/$3_$4.bam

#Remove scratch partition
cd $start_dir
rm -rf /scratch/$USER/$SLURM_JOBID
echo "exit"
