#!/bin/bash

# Written by Ceci Westbrook
# Transforms ROIs into native space and extracts the timeseries data from the registered data
# Note: this script requires already-run Feat directories, and predefined ROIs in MNI space

# This file structure departs from BIDS. Adjust as necessary
subj=$1
ROI=$2
run=$3
script_dir=/home/westbroo/Worry_and_Mindfulness/Scripts/PPI
subj_dir=/mnt/Worry_and_Mindfulness/Subjects/${subj}
PPI_dir=${subj_dir}/func/WM/model/PPI
anat_dir=${subj_dir}/anat
ROI_dir=${anat_dir}/ROIs

mkdir $ROI_dir
mkdir $PPI_dir

for feat_dir in ${subj_dir}/func/WM/model/level1/${run}_sepworry*.feat ; do

   # resample ROI into native space
   flirt -in $script_dir/$ROI -ref $feat_dir/example_func -applyxfm -init $feat_dir/reg/standard2example_func.mat -out $ROI_dir/${ROI}_resamp
   fslmaths $ROI_dir/${ROI}_resamp -bin $ROI_dir/${ROI}_resamp

   # extract timeseries from filtered_func_data
   fslmeants -i $feat_dir/filtered_func_data -o $PPI_dir/ts.$ROI.${run}.1D -m $ROI_dir/${ROI}_resamp

done
