#!/bin/tcsh

# Written by Ceci Westbrook
# 10 /2020, edited 11/2021
# motion correction and creation of motion files and fieldmaps for Worry & Mindfulness task analyses
# Note that this script was originally not written on BIDS-formatted data. It has been edited to be compatible
# with data in BIDS format, but I cannot guarantee that no errors in filepaths exist.

# This script accomplishes the following:
# a.	Reorient the labels using fslreorient2std
# b.	Skull-strips the anatomical T1s using FreeSurfer
# i.	Note: the way this is written, the FreeSurfer directories are deleted at the end to save space – however, I ended up using FS later for other things so it might be worthwhile to not delete this directory in the future
# c.	Makes the fieldmap images from the raw fieldmap scans
# d.	Removes 2 TRs from the EPIs
# e.	Runs fsl_motion_outliers to get frame displacement (FD) values at each TR, based on a user-defined threshold (in my case, I used 0.3mm). This will get used as a regressor in the level1 FEATs.

# Data directories - adapt to your file structure
set subj = $argv[1]
set base_dir = "/home/westbroo/Worry_and_Mindfulness/Subjects/${subj}"
set anat_dir = "${base_dir}/anat"
set raw_dir = "${base_dir}/func"
set fmap_dir = "${base_dir}/fmap"
set mot_thresh = 0.3

# Skullstripping the T1 images
echo "Skullstripping MPRAGE"
# reorient to standard if labels are incorrect
 fslreorient2std $anat_dir/sub-${subj}_T1w.nii.gz $anat_dir/sub-${subj}_T1w.nii.gz
 fslreorient2std $fmap_dir/sub-${subj}_magnitude1.nii.gz $fmap_dir/sub-${subj}_magnitude1.nii.gz
  fslreorient2std $fmap_dir/sub-${subj}_magnitude2.nii.gz $fmap_dir/sub-${subj}_magnitude2.nii.gz
 fslreorient2std $fmap_dir/sub-${subj}_phasediff.nii.gz $fmap_dir/sub-${subj}_phasediff.nii.gz

# Skullstripping
recon-all -autorecon1 -i $anat_dir/sub-${subj}_T1w.nii.gz -subjid autorecon -sd $anat_dir
# Note: we redid these omitting the out_orientation tag because it was causing a shift in the skull-stripped files
# relative to the original files. However, omitting this for other data sets COULD cause an L-to-R flip, so if you
# omit the tag make sure to check.
mri_convert $anat_dir/autorecon/mri/brainmask.mgz --reslice_like $anat_dir/sub-${subj}_T1w.nii.gz $anat_dir/sub-${subj}_T1w_brain.nii.gz
rm -rf $anat_dir/autorecon

# Preparing fieldmaps
echo "Preparing fieldmaps"

# this code takes the phase and mag images and constructs the fieldmap. The 2.46 number is standard for Siemens.
# Note that I take the mean of the fieldmap mag images.
fslmerge -t ${fmap_dir}/temp ${fmap_dir}/sub-${subj}_magnitude1.nii.gz -add ${fmap_dir}/sub-${subj}_magnitude2.nii.gz
fslmaths ${fmap_dir}/temp -Tmean ${fmap_dir}/Magnitude
rm ${fmap_dir}/temp
bet ${fmap_dir}/Magnitude ${fmap_dir}/Magnitude_brain -f 0.35 -m #Brain extract the magnitude image
fslmaths ${fmap_dir}/Magnitude_brain.nii.gz -ero ${fmap_dir}/Magnitude_brain.nii.gz #erode one voxel to remove marginal values
imcp ${fmap_dir}/sub-${subj}_phasediff.nii.gz ${fmap_dir}/Phase
fsl_prepare_fieldmap SIEMENS ${fmap_dir}/Phase ${fmap_dir}/Magnitude_brain ${fmap_dir}/FieldMap 2.46

foreach run (1 2)

	# make directory
	if ( ! -e $raw_dir/$run ) then
	   mkdir $raw_dir/${run}
	endif

	echo "Reorienting to standard"
	# reorient to standard
	fslreorient2std $raw_dir/sub-${subj}_task-worrymindfulness_run-0${run}_bold.nii.gz $raw_dir/sub-${subj}_task-worrymindfulness_run-0${run}_bold.nii.gz
	
	#echo "Truncating EPIs"
	# Rename EPIs prior to removing 2 TRs
	#mv $raw_dir/${run}/${subj}_WM_${run}_AP.nii.gz $raw_dir/${run}/${subj}_WM_${run}_AP_long.nii.gz

	# Remove the first 2 TRs
        fslroi $raw_dir/sub-${subj}_task-worrymindfulness_run-0${run}_bold.nii.gz  $raw_dir/sub-${subj}_task-worrymindfulness_run-0${run}_bold.nii.gz 2 -1

	# Run FD estimation for outlier detection
	echo "Running fsl_motion_outliers"
	fsl_motion_outliers -i $raw_dir/sub-${subj}_task-worrymindfulness_run-0${run}_bold.nii.gz -o $raw_dir/${subj}_run${run}_runconfound.txt --fd --thresh=$mot_thresh -p $raw_dir/run${run}_fd_plot -v > $raw_dir/$run/run${run}_outlier_output.txt

end
