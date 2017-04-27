# 03_Assemblies
*Written by: Jorge Eduardo Amaya Romero*

## Description: 

Pipeline to map paired-end reads to a reference scaffold using BWA. Alternative to the Stampy pipeline: See 01_Assemblies. 

## Scripts:

1. master.sh cleans the reference genome, breaks it into scaffolds (no use yet), and schedules the assemblies.
2. master_assembly.sh creates the index and calls the assembler per sample and partition.
3. subordinate_assembly_bwa.sh performs the assembly. 

## Usage

```
sbatch master.sh.
```

## Results

1. Assemblies_Bwa A directory with the assemblies per individual. See 03_Merge_Sort_Remove on how to continue with the analysis. 
