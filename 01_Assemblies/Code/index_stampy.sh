#!/bin/bash

#Purpose: Build the index for stampy 
#Written by: Jorge Eduardo Amaya Romero
#Date: 4/18/2017

#SBATCH -p general
#SBATCH -J stampy_index
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 0-1:00
#SBATCH --mem 40000
#SBATCH -o stampy_index%j.out
#SBATCH -e stampy_index%j.err

source new-modules.sh; module load stampy/1.0.31-fasrc01;

#Build the genome file
stampy.py -G $1 $2
#Build the hash table
stampy.py -g $1 -H $1

