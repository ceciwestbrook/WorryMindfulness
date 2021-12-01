#!/bin/bash

# This script replaces the subject and run numbers in template fsf files

script_dir=~/Worry_and_Mindfulness/Scripts
temp_dir=${script_dir}/PPI/level1
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

for contrast in AcceptFA AcceptSuppress FASuppress ; do
	sed 's/SUBNUM/'${subnum}'/g' 'template_level1_ppi_mindfulnessconditions_'${fsfname}'.fsf' > ${subnum}'_level1_ppi_'${contrast}'_'${run}'_'${fsfname}'.fsf'
	sed -i 's/RUNNUM/'${run}'/g' ${subnum}'_level1_ppi_'${contrast}'_'${run}'_'${fsfname}'.fsf'
	sed -i 's/CONTRASTNAME/'${contrast}'/g' ${subnum}'_level1_ppi_'${contrast}'_'${run}'_'${fsfname}'.fsf'

# Adjustment for different number of TRs in some subjects
	if [[ $subnum =~ (29|39|30|27|14|12) ]]; then
	  sed -i 's/351/351/g' ${subnum}'_level1_ppi_'${contrast}'_'${run}'_'${fsfname}'.fsf'
	elif [[ $subnum == 12 && $run == "run1" ]]; then
	  sed -i 's/351/351/g' ${subnum}'_level1_ppi_'${contrast}'_'${run}'_'${fsfname}'.fsf'
	elif [[ $subnum == 12 && $run == "run2" ]]; then
	  sed -i 's/351/381/g' ${subnum}'_level1_ppi_'${contrast}'_'${run}'_'${fsfname}'.fsf'
	elif [[ $subnum == 26 && $run == "run2" ]]; then
	  sed -i 's/351/378/g' ${subnum}'_level1_ppi_'${contrast}'_'${run}'_'${fsfname}'.fsf'
	else
	  sed -i 's/351/379/g' ${subnum}'_level1_ppi_'${contrast}'_'${run}'_'${fsfname}'.fsf'
	fi

	if [[ $fsfname == 'sepworry' ]] ; then
	  sed 's/SUBNUM/'${subnum}'/g' 'template_level1_ppi_mindfulnessconditions_'${fsfname}'.fsf' > ${subnum}'_level1_ppi_'${contrast}'_'${run}'_'${fsfname}'.fsf'
	  sed -i 's/RUNNUM/'${run}'/g' ${subnum}'_level1_ppi_'${contrast}'_'${run}'_'${fsfname}'.fsf'
	  sed -i 's/CONTRASTNAME/'${contrast}'/g' ${subnum}'_level1_ppi_'${contrast}'_'${run}'_'${fsfname}'.fsf'
		if [[ $subnum =~ (29|39|30|27|14|12) ]]; then
		  sed -i 's/351/351/g' ${subnum}'_level1_ppi_'${contrast}'_'${run}'_'${fsfname}'.fsf'
		elif [[ $subnum == 12 && $run == "run1" ]]; then
	  	  sed -i 's/351/351/g' ${subnum}'_level1_ppi_'${contrast}'_'${run}'_'${fsfname}'.fsf'
		elif [[ $subnum == 12 && $run == "run2" ]]; then
		  sed -i 's/351/381/g' ${subnum}'_level1_ppi_'${contrast}'_'${run}'_'${fsfname}'.fsf'
		elif [[ $subnum == 26 && $run == "run2" ]]; then
		  sed -i 's/351/378/g' ${subnum}'_level1_ppi_'${contrast}'_'${run}'_'${fsfname}'.fsf'
		else
		  sed -i 's/351/379/g' ${subnum}'_level1_ppi_'${contrast}'_'${run}'_'${fsfname}'.fsf'
		fi
	fi
	done

	if [[ $fsfname == 'sepworry' ]] ; then
	  sed 's/SUBNUM/'${subnum}'/g' 'template_level1_ppi_mindfulnessconditions_'${fsfname}'.fsf' > ${subnum}'_level1_ppi_WNyesno_'${run}'_'${fsfname}'.fsf'
	  sed -i 's/RUNNUM/'${run}'/g' ${subnum}'_level1_ppi_WNyesno_'${run}'_'${fsfname}'.fsf'
	  sed -i 's/CONTRASTNAME/WNyesno/g' ${subnum}'_level1_ppi_WNyesno_'${run}'_'${fsfname}'.fsf'
		if [[ $subnum =~ (29|39|30|27|14|12) ]]; then
		  sed -i 's/351/351/g' ${subnum}'_level1_ppi_WNyesno_'${run}'_'${fsfname}'.fsf'
		elif [[ $subnum == 12 && $run == "run1" ]]; then
	  	  sed -i 's/351/351/g' ${subnum}'_level1_ppi_WNyesno_'${run}'_'${fsfname}'.fsf'
		elif [[ $subnum == 12 && $run == "run2" ]]; then
		  sed -i 's/351/381/g' ${subnum}'_level1_ppi_WNyesno_'${run}'_'${fsfname}'.fsf'
		elif [[ $subnum == 26 && $run == "run2" ]]; then
		  sed -i 's/351/378/g' ${subnum}'_level1_ppi_WNyesno_'${run}'_'${fsfname}'.fsf'
		else
		  sed -i 's/351/379/g' ${subnum}'_level1_ppi_WNyesno_'${run}'_'${fsfname}'.fsf'
		fi

	  sed 's/SUBNUM/'${subnum}'/g' 'template_level1_ppi_DisengageALL_sepworry.fsf' > ${subnum}'_level1_ppi_DisengageALL_'${run}'_'${fsfname}'.fsf'
	  sed -i 's/RUNNUM/'${run}'/g' ${subnum}'_level1_ppi_DisengageALL_'${run}'_'${fsfname}'.fsf'
		if [[ $subnum =~ (29|39|30|27|14|12) ]]; then
		  sed -i 's/351/351/g' ${subnum}'_level1_ppi_DisengageALL_'${run}'_'${fsfname}'.fsf'
		elif [[ $subnum == 12 && $run == "run1" ]]; then
	  	  sed -i 's/351/351/g' ${subnum}'_level1_ppi_DisengageALL_'${run}'_'${fsfname}'.fsf'
		elif [[ $subnum == 12 && $run == "run2" ]]; then
		  sed -i 's/351/381/g' ${subnum}'_level1_ppi_DisengageALL_'${run}'_'${fsfname}'.fsf'
		elif [[ $subnum == 12 && $run == "run2" ]]; then
		  sed -i 's/351/378/g' ${subnum}'_level1_ppi_DisengageALL_'${run}'_'${fsfname}'.fsf'
		else
		  sed -i 's/351/379/g' ${subnum}'_level1_ppi_DisengageALL_'${run}'_'${fsfname}'.fsf'
		fi

	  sed 's/SUBNUM/'${subnum}'/g' 'template_level1_ppi_DisengageALL_fullreg_sepworry.fsf' > ${subnum}'_level1_ppi_DisengageALL_fullreg_'${run}'_'${fsfname}'.fsf'
	  sed -i 's/RUNNUM/'${run}'/g' ${subnum}'_level1_ppi_DisengageALL_fullreg_'${run}'_'${fsfname}'.fsf'
		if [[ $subnum =~ (29|39|30|27|14|12) ]]; then
		  sed -i 's/351/351/g' ${subnum}'_level1_ppi_DisengageALL_fullreg_'${run}'_'${fsfname}'.fsf'
		elif [[ $subnum == 12 && $run == "run1" ]]; then
	  	  sed -i 's/351/351/g' ${subnum}'_level1_ppi_DisengageALL_fullreg_'${run}'_'${fsfname}'.fsf'
		elif [[ $subnum == 12 && $run == "run2" ]]; then
		  sed -i 's/351/381/g' ${subnum}'_level1_ppi_DisengageALL_fullreg_'${run}'_'${fsfname}'.fsf'
		elif [[ $subnum == 26 && $run == "run2" ]]; then
		  sed -i 's/351/378/g' ${subnum}'_level1_ppi_DisengageALL_fullreg_'${run}'_'${fsfname}'.fsf'
		else
		  sed -i 's/351/379/g' ${subnum}'_level1_ppi_DisengageALL_fullreg_'${run}'_'${fsfname}'.fsf'
		fi

	fi
   done
done
