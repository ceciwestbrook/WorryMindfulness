#!/bin/bash

# This script replaces the subject and run numbers in template fsf files

temp_dir=~/Worry_and_Mindfulness/Scripts/level2/sepworry
inputdir=~/Worry_and_Mindfulness/Scripts/runs_to_exclude

cd $temp_dir

for dirname in /mnt/Worry_and_Mindfulness/Subjects/* ; do
    subnum=`echo $dirname | tr -cd '[:digit:]'`
    echo $subnum
for run in run1 run2 ; do
    if [[ -d $dirname/func/WM/model/level1/${run}_sepworry_ONLYworry.feat ]] ; then
    
    lv1_dir=/mnt/Worry_and_Mindfulness/Subjects/${subnum}/func/WM/model/level1
    featname=${run}_sepworry_ONLYworry
    for copename in DisengagementWNyesRest DisengagementWNyesWorry DisengagementWNyesASF ; do
    sed 's/SUBNUM/'${subnum}'/g' level2_template_sepworry_indiv_cope.fsf > ${subnum}'_level2_sepworry_'${copename}'.fsf'
    sed -i 's/COPENAME/'${copename}'/g' ${subnum}'_level2_sepworry_'${copename}'.fsf'
    
    case $copename in
    DisengagementWNyesRest)
	echo $run $copename
	sed -i "s/${run}_DIRNAME/${featname}/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
	sed -i "s/${run}cope/cope12/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
	othercope='cope13'
    ;;
    DisengagementWNyesWorry)
	echo $run $copename
	sed -i "s/${run}_DIRNAME/${featname}/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
	sed -i "s/${run}cope/cope13/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
	othercope='cope16'
    ;;
    DisengagementWNyesASF)
	echo $run $copename
	sed -i "s/${run}_DIRNAME/${featname}/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
	sed -i "s/${run}cope/cope14/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
	othercope='cope18'
    ;;
    esac
	sed -i "s/DIRNAME/sepworry/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
	sed -i "s/run1cope/${othercope}/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
	sed -i "s/run2cope/${othercope}/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
    done

    fi

if [[ -d $dirname/func/WM/model/level1/${run}_sepworry_NOworry.feat ]] ; then
    
    lv1_dir=/mnt/Worry_and_Mindfulness/Subjects/${subnum}/func/WM/model/level1
    featname=${run}_sepworry_NOworry
    for copename in DisengagementWNnoRest DisengagementWNnoWorry DisengagementWNnoASF ; do
    sed 's/SUBNUM/'${subnum}'/g' level2_template_sepworry_indiv_cope.fsf > ${subnum}'_level2_sepworry_'${copename}'.fsf'
    sed -i 's/COPENAME/'${copename}'/g' ${subnum}'_level2_sepworry_'${copename}'.fsf'
    
    case $copename in
    DisengagementWNnoRest)
	echo $run $copename
	sed -i "s/${run}_DIRNAME/${featname}/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
	sed -i "s/${run}cope/cope12/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
	othercope='cope14'
    ;;
    DisengagementWNnoWorry)
	echo $run $copename
	sed -i "s/${run}_DIRNAME/${featname}/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
	sed -i "s/${run}cope/cope13/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
	othercope='cope17'
    ;;
    DisengagementWNnoASF)
	echo $run $copename
	sed -i "s/${run}_DIRNAME/${featname}/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
	sed -i "s/${run}cope/cope14/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
	othercope='cope19'
    ;;
    esac
	sed -i "s/DIRNAME/sepworry/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
	sed -i "s/run1cope/${othercope}/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
	sed -i "s/run2cope/${othercope}/g" ${subnum}'_level2_sepworry_'${copename}'.fsf'
    done

    fi
done

for copename in WorryWNyesno DisengagementWNyesno; do
	featdir=$dirname/func/level1

	if [[ -d $featdir/run1_sepworry.feat && ! -d $featdir/run2_sepworry.feat ]] ; then
	   sed 's/SUBNUM/'${subnum}'/g' template_level2_sepworry_${copename}_norun2.fsf > "${subnum}_level2_${copename}_sepworry_norun2.fsf"
    	   sed -i 's/COPENAME/'${copename}'/g' "${subnum}_level2_${copename}_sepworry_norun2.fsf"
	   sed -i "/run/s/DIRNAME/${featname}/g" "${subnum}_level2_${copename}_sepworry_norun2.fsf"
	elif [[ -d $featdir/run2_sepworry.feat && ! -d $featdir/run1_sepworry.feat ]] ; then
	   sed 's/SUBNUM/'${subnum}'/g' template_level2_sepworry_${copename}_norun1.fsf > "${subnum}_level2_${copename}_sepworry_norun1.fsf"
    	   sed -i 's/COPENAME/'${copename}'/g' "${subnum}_level2_${copename}_sepworry_norun1.fsf"
	   sed -i "/run2/s/DIRNAME/${featname}/g" "${subnum}_level2_${copename}_sepworry_norun1.fsf"
	fi
   done	
done
