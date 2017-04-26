#!/bin/bash

#https://bugs.schedmd.com/show_bug.cgi?id=3214

for i in sta*.err; do
		echo $i
		i=${i#sta_assemble}
		i=${i%.err}
		echo $i
		sacct -j $i -o jobid,jobname,state,exitcode,derivedexitcode
	done 
