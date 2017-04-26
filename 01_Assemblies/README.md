# 01_Assemblies
*Written by: Jorge Eduardo Amaya Romero*

##Description: Pipeline to map paired-end reads to a reference scaffold using Stampy. Although no precise data on which aligner is better (and there are hundreds out there), [a preliminar assessment](http://www.heliconius.org/2013/aligning-heliconius-short-read-sequences/) made by John Davey in 2013 showed that, when aligning reads of relatively distant clades to the Heliconius genome, Stampy outperformed most of its competitors in most of the metrics except running time. This pipeline takes advantage of ``Stampy`s`` ```partition``` feature to distribute the job in Odyssey. By running the assemblies in the idling resources of Odyssey instead of the general or bigmem partitions, these pipeline can align the complete set of reads for one individual in less than a day (a job that normally takes several weeks). For full disclosure: John Davey`s post is slightly old and aligners may have moved on a while since then, but we are sticking to it as a general guideline...

##Scripts:

1. master.sh cleans the reference genome, breaks it into scaffolds (no use yet), and schedules the assemblies.
2. master_assembly.sh creates the index and calls the assembler per sample and partition.
3. subordinate_assembly_stampy.sh performs the assembly. 

##Usage

```
sbatch master.sh.
```

##Results

1. Assemblies_Stampy A directory with the assemblies per individual. See 02_Merge_Sort_Remove on how to merge the files and continue with the analysis. 

##Note
``Slurm`s`` ```slurmstepd: error: Exceeded step memory limit at some point``` message ``it`s`` known to be buggy and ``doesn`t`` necessarily inform that your processes ``didn`t`` run successfully (see [here](https://bugs.schedmd.com/show_bug.cgi?id=3214)). To verify is your script ran successfully, run ``./verify.sh | grep "CANCELLED"``. If any of the processes was cancelled, you may have to rerun the program subordinate_assembly_stampy.sh with increased memory.
