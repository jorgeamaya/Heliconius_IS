#!/bin/bash

#Purpose: Assemble genomes with Stampy
#Written by: Jorge Eduardo Amaya Romero
#Date: 4/18/2017

#SBATCH -p serial_requeue,general
#SBATCH -J bwa_assemble
#SBATCH -n 20
#SBATCH -N 1
#SBATCH --ntasks-per-node=20
#SBATCH -t 1-0:00
#SBATCH --mem 80000
#SBATCH -o bwa_assemble%j.out
#SBATCH -e bwa_assemble%j.err

source new-modules.sh; module load bwa/0.7.9a-fasrc03; module load samtools/1.4-fasrc01; 

cd Results
rm -r Assemblies_Bwa/$3
mkdir -p Assemblies_Bwa/$3
#Create a partition in scratch to prevent clogging the home directory
start_dir=$PWD
mkdir -p /scratch/$USER/$SLURM_JOBID 
#Copy the bwa index to scratch
cp Hel* /scratch/$USER/$SLURM_JOBID/.
#Jump to the partition
cd /scratch/$USER/$SLURM_JOBID

#Assemble!
bwa mem -M -R '@RG\tID:group1\tSM:sample1\tPL:illumina\tLB:lib1\tPU:unit1' $4 $1 $2 -t 20 | samtools sort -O BAM -o $3.bam -T tmp -

#Remove scratch partition
cp $3.bam $start_dir/Assemblies_Bwa/$3/.
cd $start_dir
rm -rf /scratch/$USER/$SLURM_JOBID
