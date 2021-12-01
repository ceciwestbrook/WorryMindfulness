# Ceci Westbrook, 11/2021

This directory contains the scripts for PPI analyses. This analysis pathway is based on one originally developed by Russ Poldrack and adapted by Jeanette Mumford. The steps in the pathway are as follows:
	1. extract the average timeseries from registered fMRI data in MNI space using fslmeants. The seed is included in this directory in nifti format (PCC_MNI_nudge.nii).
	> 0_extract_timeseries.sh
	
	2. Deconvolve the HRF from this timeseries using SPM and the timings from the task. This will create 2 new regressors for each contrast of interest (the pos and neg direction of the contrast). The required code and dependencies are all in the fslppi directory.
	> run_ppi_sepworry_***.m
	
	3. include the timeseries and the 2 new regressors in the original feat model and re-run the feat. Note that this was done separately for each contrast, because including all of these regressors at once could make the model too collinear.
	
	> level1/make_fsf_PPI_from_template_level1.sh
	
Note that in addition to re-running the original model 4 times, to run the PPI for the 3 mindfulness contrasts (Accept - Suppress etc.) and the Successful - Unsuccessful Disengagement contrast, we also assessed Successful - Unsuccessful Disengagement across the full disengagement period (this is called DisengageALL).

A final note that these analyses required use of analyzed data which by nature is not in BIDS format. File paths will likely need to be changed depending on where you put your completed Feat directories, extracted timeseries et al.