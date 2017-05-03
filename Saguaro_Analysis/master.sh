#!/bin/bash

#Purpose: Master script to run Saguaro analysis from H. pardalinus and H. elevatus data
#Written by: Jorge Eduardo Amaya Romero
#Date: 3/6/2017

#SBATCH -p general
#SBATCH -J master
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 0-1:00
#SBATCH --mem 40000
#SBATCH -o master%j.out
#SBATCH -e master%j.err

#Link the vcf file with your data
ln -s /path/to/file/ Data/.
sbatch Code/master_saguaro.sh Hel_Par_Ele_H12.vcf ~/Software/Software_Repository/saguarogw-code-44.zip

#You can also download a sample file from the Human 1000 Genome Project. Uncomment the following lines and comment the previous ones.
#tabix -h ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr12.phase1.projectConsensus.genotypes.vcf.gz 12:10000-110000 > Data/1000.vcf
#sbatch Code/master_saguaro.sh 1000.vcf /path/to/saguaro.zip #Provide the name of the vcf file and the path to saguaro's zip file
