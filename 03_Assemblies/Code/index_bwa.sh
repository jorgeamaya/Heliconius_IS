#!/bin/bash

#Purpose: Build the index for bwa
#Written by: Jorge Eduardo Amaya Romero
#Date: 4/18/2017

#SBATCH -p general
#SBATCH -J bwa_index
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 0-1:00
#SBATCH --mem 40000
#SBATCH -o bwa_index%j.out
#SBATCH -e bwa_index%j.err

source new-modules.sh;  module load bwa/0.7.9a-fasrc03; 

#Build the genome file
bwa index -p $1 $1 

