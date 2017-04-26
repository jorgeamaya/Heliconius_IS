#!/bin/bash

#Purpose: Master script to run SLIM simulations in Odyssey
#Written by: Jorge Eduardo Amaya Romero
#Date: 3/6/2017

#SBATCH -p general
#SBATCH -J saguaro
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 5-0:00
#SBATCH --mem 40000
#SBATCH -o saguaro%j.out
#SBATCH -e saguaro%j.err

source new-modules.sh; module load gcc/6.3.0-fasrc01

#Create a directory in scratch
star_dir=$PWD
echo $star_dir
mkdir -p /scratch/$USER/$SLURM_JOBID

#Copy saguaro's zip and compile.
#cp ~/Software/Software_Repository/saguarogw-code-44.zip /scratch/$USER/$SLURM_JOBID/.
cp $2 /scratch/$USER/$SLURM_JOBID/.
cd /scratch/$USER/$SLURM_JOBID
unzip saguarogw-code-44.zip
cd /scratch/$USER/$SLURM_JOBID/saguarogw-code-44
make

#Copy the data for the analysis
cp -r $star_dir/Data .

#Run Saguaro nd copy the results back to home
mkdir Saguaro_OUT
VCF2HMMFeature -i Data/$1 -o Data/vcf.feature -m 20 -nosame > Saguaro_OUT/vcfoutfile.out
Saguaro -f Data/vcf.feature -o Saguaro_OUT/HMM_out -iter 1 > Saguaro_OUT/Table_output.out
cp -r Saguaro_OUT $star_dir/Results/.

#Clean  scratch
cd $star_dir
rm -rf /scratch/$USER/$SLURM_JOBID
