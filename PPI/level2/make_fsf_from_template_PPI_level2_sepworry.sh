#!/bin/bash

# This script replaces the subject and run numbers in template fsf files

temp_dir=~/Worry_and_Mindfulness/Scripts/PPI/level2

cd $temp_dir

for dirname in /mnt/Worry_and_Mindfulness/Subjects/*
do
   subnum=`echo "$dirname" | tr -cd '[:digit:]'`
   for copename in AcceptFA_fullreg AcceptSuppress_fullreg FASuppress_fullreg ; do
	lv1_dir=/mnt/Worry_and_Mindfulness/Subjects/${subnum}/func/WM/model/PPI/level1
	sed 's/SUBNUM/'${subnum}'/g' template_level2_ppi_mindfulnessconditions_partial.fsf > "${subnum}_level2_ppi_${copename}_partial.fsf"

	featname=""
	altrun=""
	for run in run1 run2
	do
    	    if [[ `ls -d ${lv1_dir}/${run}*ONLYworry* 2>/dev/null` ]] ; then
		featname='sepworry_ONLYworry'
		altrun=$run
    	    elif [[ `ls -d ${lv1_dir}/${run}*NOworry* 2>/dev/null` ]] ; then
		featname='sepworry_NOworry'
		altrun=$run
    	    fi
	  echo $subnum' '$run' '$featname' '$altrun
	done
	    if [[ $altrun != "" ]] ; then
	    	sed -i "/${altrun}/s/DIRNAME/${featname}/g" "${subnum}_level2_ppi_${copename}_partial.fsf"
		sed -i "s/DIRNAME/sepworry/g" "${subnum}_level2_ppi_${copename}_partial.fsf"
	    	sed -i 's/COPENAME/'${copename}'/g' "${subnum}_level2_ppi_${copename}_partial.fsf"
	    else
		sed 's/SUBNUM/'${subnum}'/g' template_level2_ppi_mindfulnessconditions.fsf > "${subnum}_level2_ppi_${copename}_sepworry.fsf"
    	   	sed -i 's/COPENAME/'${copename}'/g' "${subnum}_level2_ppi_${copename}_sepworry.fsf"
    	   	rm "${subnum}_level2_ppi_${copename}_partial.fsf"
	    fi
	
   done

   for copename in WNyesno_fullreg DisengageALL_fullreg; do
	featdir=$dirname/func/WM/model/PPI/level1

	if [[ -d $featdir/run1_PPI_${copename}_sepworry.feat && -d $featdir/run2_PPI_${copename}_sepworry.feat ]] ; then
	   sed 's/SUBNUM/'${subnum}'/g' template_level2_ppi_mindfulnessconditions.fsf > "${subnum}_level2_ppi_${copename}_sepworry.fsf"
    	   sed -i 's/COPENAME/'${copename}'/g' "${subnum}_level2_ppi_${copename}_sepworry.fsf"
	elif [[ -d $featdir/run1_PPI_${copename}_sepworry.feat && ! -d $featdir/run2_PPI_${copename}_sepworry.feat ]] ; then
	   sed 's/SUBNUM/'${subnum}'/g' template_level2_ppi_mindfulnessconditions_norun2.fsf > "${subnum}_level2_ppi_${copename}_sepworry_norun2.fsf"
    	   sed -i 's/COPENAME/'${copename}'/g' "${subnum}_level2_ppi_${copename}_sepworry_norun2.fsf"
	   sed -i "/run/s/DIRNAME/${featname}/g" "${subnum}_level2_ppi_${copename}_sepworry_norun2.fsf"
	elif [[ -d $featdir/run2_PPI_${copename}_sepworry.feat && ! -d $featdir/run1_PPI_${copename}_sepworry.feat ]] ; then
	   sed 's/SUBNUM/'${subnum}'/g' template_level2_ppi_mindfulnessconditions_norun1.fsf > "${subnum}_level2_ppi_${copename}_sepworry_norun1.fsf"
    	   sed -i 's/COPENAME/'${copename}'/g' "${subnum}_level2_ppi_${copename}_sepworry_norun1.fsf"
	   sed -i "/run2/s/DIRNAME/${featname}/g" "${subnum}_level2_ppi_${copename}_sepworry_norun1.fsf"
	fi
   done
done
