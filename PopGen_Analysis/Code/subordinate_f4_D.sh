#!/bin/bash

#Purpose: Master script to ABBA test
#Written by: Jorge Eduardo Amaya Romero
#Date: 3/6/2017

#SBATCH -p general
#SBATCH -J popgenome
#SBATCH -n 5
#SBATCH -N 1
#SBATCH -t 5-0:00
#SBATCH --mem 40000
#SBATCH -o popgenome%j.out
#SBATCH -e popgenome%j.err

source new-modules.sh; module load python/2.7.11-fasrc01

#Create a directory in scratch
star_dir=$PWD
echo $star_dir
mkdir -p /scratch/$USER/$SLURM_JOBID
cd /scratch/$USER/$SLURM_JOBID

mkdir PopGenome
cp $star_dir/Code/genomics_general/genomics* .
#Copy the data for the analysis
python2.7 $star_dir/Code/genomics_general/ABBABABAwindows.py -w $2 -m $3 -s $4 -g $star_dir/Results/PopGenome/${1##*/}.geno.gz -o PopGenome/${1##*/}.csv -f phased -T 5 -p $5 HG00096,HG00097,HG00099 -p $6 HG00100,HG00101,HG00102 -p $7 HG00104,HG00106,HG00108 -p 0 HG00109,HG00110,HG00111 
cp -r PopGenome/* $star_dir/Results/PopGenome/.

#Clean  scratch
cd $star_dir
rm -rf /scratch/$USER/$SLURM_JOBID
