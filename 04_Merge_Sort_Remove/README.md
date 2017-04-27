# 04_Merge_Sort_Remove
*Written by: Jorge Eduardo Amaya Romero*

## Description: 
Merger, sort and mark duplicates of alignments produced with stampy.

## Scripts:

1. subordinate_make_dict.sh creates the reference dictionary 
2. subordinate_remove_duplicates.sh marks duplicates
3. subordinate_realign_step1.sh determines the intervals to realign the indels
4. subordinate_realign_step2.sh realigns the indels
5. subordinate_call_variants.sh calls the variants with HaplotypeCaller  
5. subordinate_call_variants2.sh calls the variants with UnifiedGnotyper

## Usage

```
sbatch master.sh.
```

## Results

1. A directory per sample with the clean bam file and vcf file with variants

