#!/bin/bash

# This script replaces the subject and run numbers in template fsf files

temp_dir=~/Worry_and_Mindfulness/Scripts/level2/sepworry

cd $temp_dir

for dirname in ~/Worry_and_Mindfulness/Subjects/*
do
	subnum=`echo "$dirname" | tr -cd '[:digit:]'`

	lv1_dir=/mnt/Worry_and_Mindfulness/Subjects/${subnum}/func/level1
	sed 's/SUBNUM/'${subnum}'/g' level2_template_sepworry_partial.fsf > ${subnum}'_level2_sepworry_partial.fsf'

checkruns=0
  for run in run1 run2
    do
    if [[ `ls -d ${lv1_dir}/${run}*ONLYworry* 2>/dev/null` ]] ; then
	featname='sepworry_ONLYworry'
	checkruns=1
    elif [[ `ls -d ${lv1_dir}/${run}*NOworry* 2>/dev/null` ]] ; then
	featname='sepworry_NOworry'
	checkruns=1
    else
	featname='sepworry'
    fi
	sed -i "s/${run}_DIRNAME/${run}_${featname}/g" "${subnum}_level2_sepworry_partial.fsf"
    done

    echo $subnum' '$featname' '$checkruns
if [[ $checkruns == 0 ]] ; then
    sed 's/SUBNUM/'${subnum}'/g' level2_template_sepworry.fsf > ${subnum}'_level2_sepworry.fsf'
    rm ${subnum}_level2_sepworry_partial.fsf
fi

done
