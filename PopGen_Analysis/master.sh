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

window_size=50000
min_complete_sites=5000
step_size=25000
name_pop1=elevatus_1
name_pop2=pardalinus_1
name_pop3=elevatus_2
name_pop4=pardalines_2
vcf_file=1000.vcf #Hel_Par_Ele_H12.vcf

source new-modules.sh; module load git/2.1.0-fasrc01

mkdir Data
mkdir Results

cd Code
git clone https://github.com/simonhmartin/genomics_general.git

#This code was produced with version 7240bca. I strongly advice to use more current version since they may include big fixes and performance improvements. Nonetheless, given the case new version become imcompatible, you can revert to the original 7240bca version by removing the marks. 
:<<VERSION
cd genomics_general
git reset --hard 7240bca
cd ../
VERSION

cd ../

#Link the vcf file with your data
#ln -s /path/to/file/ Data/.

#You can also download a sample file from the Human 1000 Genome Project. Uncomment the following lines and comment the previous ones.
#module load tabix
#tabix -h ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr12.phase1.projectConsensus.genotypes.vcf.gz 12:10000-110000 > Data/1000.vcf

vcftogeno=`sbatch Code/subordinate_vcftogeno.sh $vcf_file | cut -d ' ' -f 4`  #Provide the name of the vcf file
sbatch --dependency=afterok:$vcftogeno Code/subordinate_popgenome.sh $vcf_file $window_size $min_complete_sites $step_size $name_pop1 $name_pop2 $name_pop3 $name_pop4
sbatch --dependency=afterok:$vcftogeno Code/subordinate_f4_D.sh $vcf_file $window_size $min_complete_sites $step_size $name_pop1 $name_pop2 $name_pop3 $name_pop4
sbatch --dependency=afterok:$vcftogeno Code/subordinate_tree.sh $vcf_file $window_size 
