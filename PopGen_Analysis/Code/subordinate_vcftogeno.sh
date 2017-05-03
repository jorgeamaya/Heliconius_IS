#!/bin/bash

#Purpose: Master script to run SLIM simulations in Odyssey
#Written by: Jorge Eduardo Amaya Romero
#Date: 3/6/2017

#SBATCH -p general
#SBATCH -J statgenome
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 5-0:00
#SBATCH --mem 40000
#SBATCH -o statgenome%j.out
#SBATCH -e statgenome%j.err

source new-modules.sh; module load python/2.7.11-fasrc01

#Create a directory in scratch
star_dir=$PWD
echo $star_dir
mkdir -p /scratch/$USER/$SLURM_JOBID
cd /scratch/$USER/$SLURM_JOBID

mkdir PopGenome
#Copy the data for the analysis
python2.7 $star_dir/Code/genomics_general/VCF_processing/parseVCF.py -i $star_dir/Data/$1 --skipIndel --minQual 30 | gzip > PopGenome/${1##*/}.geno.gz 

cp -r PopGenome $star_dir/Results/.

#Clean  scratch
cd $star_dir
rm -rf /scratch/$USER/$SLURM_JOBID
