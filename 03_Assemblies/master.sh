#!/bin/bash

#Purpose: Master script to assemble the genomes
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

#Link the reference genome
ln -n /n/home11/jromero/Heliconius_IS/Data/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa Data/.

#Clean the headers
cut -d ' ' -f1 Data/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa > Results/Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa
#Break the reference genome by scaffold
mkdir Results/Scaffold
cd Results/Scaffold
awk '/^>/ {OUT=substr($0,2) ".fa"}; {print >> OUT; close(OUT)}' ../Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa
awk '/^>/ {OUT=substr($0,2) ".fa";print " ">OUT}; OUT{print >OUT}' ../Heliconius_melpomene_melpomene_Hmel2_-_scaffolds.fa
cd ../../

sbatch Code/master_assembly.sh
