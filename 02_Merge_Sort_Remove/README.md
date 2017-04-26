# 01_Assemblies
*Written by: Jorge Eduardo Amaya Romero*

## Description: Merger, sort and mark duplicates of alignments produced with stampy.

## Scripts:

1. subordinate_make_dict.sh creates the reference dictionary 
2. subordinate_merge.sh	merge the bam files produced by stampy       
3. subordinate_fixheader.sh fix the header of the bam file 
4. subordinate_remove_duplicates.sh marks duplicates
5. subordinate_realign_step1.sh determines the intervals to realign the indels
6. subordinate_realign_step2.sh realigns the indels
7.1. subordinate_call_variants.sh calls the variants with HaplotypeCaller  
7.2. subordinate_call_variants2.sh calls the variants with UnifiedGnotyper

## Usage

```
sbatch master.sh.
```

## Results

1. A directory per sample with the clean bam file and vcf file with variants

