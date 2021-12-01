#!/bin/bash

# This script replaces the subject and run numbers in template fsf files

temp_dir=~/Worry_and_Mindfulness/Scripts/level1/sepworry
run1ONLYworry=(14 38 03 37 21 28)
run2ONLYworry=(29 03 21 28)
run1NOworry=(40 26 31)
run2NOworry=(22 24 06 31 33)

cd $temp_dir

for dirname in ~/Worry_and_Mindfulness/Subjects/*
do
	subnum=`echo "$dirname" | tr -cd '[:digit:]'`
	for run in run1 run2 ; do
	fsfname='sepworry'
	if [[ $run == "run1" ]]; then
	  if [[ ${run1ONLYworry[@]} =~ $subnum ]] ; then
	    fsfname='sepworry_ONLYworry'
	  fi
	  if [[ ${run1NOworry[@]} =~ $subnum ]] ; then
	    fsfname='sepworry_NOworry'
	  fi
	fi
	if [[ $run == "run2" ]]; then
	  if [[ ${run2ONLYworry[@]} =~ $subnum ]] ; then
	    fsfname='sepworry_ONLYworry'
	  fi
	  if [[ ${run2NOworry[@]} =~ $subnum ]] ; then
	    fsfname='sepworry_NOworry'
	  fi
	fi
	echo $subnum' '$subj' '$run' '$fsfname
	sed 's/SUBNUM/'${subnum}'/g' 'template_'${fsfname}'.fsf' > ${subnum}'_'${run}'_lv1'${fsfname}'.fsf'
	sed -i 's/RUNNUM/'${run}'/g' ${subnum}'_'${run}'_lv1'${fsfname}'.fsf'
	
	# adjustment for different numbers of TRs		
	if [[ $subnum =~ (29|39|30|27|14|12) ]]; then
	  sed -i 's/381/351/g' ${subnum}'_'${run}'_lv1'${fsfname}'.fsf'
	elif [[ $subnum == 26 && $run == "run2" ]]; then
	  sed -i 's/381/378/g' ${subnum}'_'${run}'_lv1'${fsfname}'.fsf'
	else
	  sed -i 's/381/379/g' ${subnum}'_'${run}'_lv1'${fsfname}'.fsf'
	fi
	
	if [[ $fsfname == 'sepworry' ]] ; then
	   	sed 's/SUBNUM/'${subnum}'/g' 'template_'${fsfname}'.fsf' > ${subnum}'_'${run}'_lv1'${fsfname}'.fsf'
		sed -i 's/RUNNUM/'${run}'/g' ${subnum}'_'${run}'_lv1'${fsfname}'.fsf'
		if [[ $subnum =~ (29|39|30|27|14|12) ]]; then
	  	  sed -i 's/381/351/g' ${subnum}'_'${run}'_lv1'${fsfname}'.fsf'
	  	elif [[ $subnum == 26 && $run == "run2" ]]; then
	  	  sed -i 's/381/378/g' ${subnum}'_'${run}'_lv1'${fsfname}'.fsf'
		  else
	  	  sed -i 's/381/379/g' ${subnum}'_'${run}'_lv1'${fsfname}'.fsf'
		fi
	fi
	done
	
done
