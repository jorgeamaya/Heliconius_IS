#!/bin/bash

#Purpose: Master script to obtain tree in sliding windows
#Written by: Jorge Eduardo Amaya Romero
#Date: 3/6/2017

#SBATCH -p general
#SBATCH -J popgenome
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 5-0:00
#SBATCH --mem 40000
#SBATCH -o popgenome%j.out
#SBATCH -e popgenome%j.err

source new-modules.sh; module load python/2.7.11-fasrc01; module load phyml/2014Oct16-fasrc01

#Create a directory in scratch
star_dir=$PWD
echo $star_dir
mkdir -p /scratch/$USER/$SLURM_JOBID
cd /scratch/$USER/$SLURM_JOBID

mkdir PopGenome
cp $star_dir/Code/genomics_general/genomics* .
#Copy the data for the analysis
python2.7 $star_dir/Code/genomics_general/phylo/phyml_sliding_windows.py -g $star_dir/Results/PopGenome/${1##*/}.geno.gz --prefix PopGenome/${1##*/}.phyml.w$2 -w $2 --windType sites --model GTR --genoFormat phased -T 1 
cp -r PopGenome/* $star_dir/Results/PopGenome/.

#Clean  scratch
cd $star_dir
rm -rf /scratch/$USER/$SLURM_JOBID
