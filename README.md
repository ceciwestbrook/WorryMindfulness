# WorryMindfulness
This is the accompanying analysis code for the Worry and Mindfulness Project, PI Hallion. Please see our preregistration at https://osf.io/tsd74 for more information.

All code and associated documents were written by Ceci Westbrook 2020-2021 unless otherwise noted.

 # Task description: # 
Participants provided self-generated worry topics during an interview on a preceding session, which were converted to scanner stimuli. The fMRI task was completed on a subsequent visit, during which they were also instructed in worry disengagement strategies. The task comprised 2 runs of 6 trials each. For each trial, self-generated worry stimuli were presented for 35s, followed by a 35s disengagement period in which participants were instructed to disengage from worry using one of 2 mindfulness strategies (focused acceptance, acceptance) or a control strategy (suppression). Following disengagement, participants responded to thought probes indicating whether they were successful at worry disengagement.

 # How to use this repository: # 
This dataset was analyzed primarily using FSL's Feat program, which takes design files (.fsf) as input. These files can be batch-edited and submitted, which was the approach used here, following Jeanette Mumford's approach (please see: https://www.youtube.com/playlist?list=PLB2iAtgpI4YHlH4sno3i3CUjCofI38a-3). The order of use for these scripts are:
 1) Preprocessing using the 0_preprocess script in this directory
 2) level 1 analyses conducted by batch-editing the template .fsf scripts found in the level1/ directory
 3) the same process for level 2 analyses; and finally
 4) group-level analyses utilizing the template scripts in the group_level directory

 # Data included: # 
All imaging data was collected on a 3T MRI scanner (MAGNETOM Verio syngo MR B17, 		Siemens Corporation) with a 32-channel radio-frequency (RF) head coil array.

Anatomical 
T1-weighted structural images (1 mm3 voxels) were acquired in the sagittal plane with an isotropic MPRAGE sequence using a parallel imaging factor of 2 (TR=2300, TE=1.97, TI = 900, flip angle = 9º, voxel size = 1mm3, matrix size 256x256).

Functional
T2*-weighted gradient-echo echo-planar images without parallel imaging (TR = 2000, TE = 27.2, flip angle = 79º, voxel size = 3.0x3.0x3.0mm, matrix size 70x70, orientation T>C-30, 51 interleaved slices). Two runs were collected of duration 11m46s (353 volumes; first six subjects) or 12m42s (381 volumes; all remaining subjects).

Fieldmap
Siemens gradient-echo fieldmap sequence (TR = 724, TE 1 = 5, TE2 = 7.46, effective echo spacing = 0.56, phase encode direction A>>P).

 # Preregistration: # 
This dataset corresponds to pre-registered analyses which can be found here: https://osf.io/tsd74 (updates to preregistration at https://osf.io/b8exs).

 # Associated neural data # 
This code is associated with a neural dataset published on openneuro.org. DOI for this dataset will be added when it becomes publicly available.

 # Data collection and acknowledgements: # 
Data were collected in 2018 at the Science Imaging Brain Research (SIBR) Center at Carnegie Mellon University and supported by the following funding sources:

University of Pittsburgh Central Research Development Fund Hallion (PI)
CRDF 30637
Neurobiological Mechanisms Underlying the Acute Effects of Mindfulness on Worry and Rumination
CMU-Pitt Brain Imaging Data Generation & Education (BRIDGE) Center
Developmental Fund Seed Grant Hallion (PI)
Neural Mechanisms of Mindful Disengagement from Worry

 # Authors: # 
Cecilia A. Westbrook1, Janine Dutcher2, Susan Kusmierski3, J. David Creswell2, Essang Akpan3, and Lauren S. Hallion3
1Department of Psychiatry, University of Pittsburgh Medical Center
2Department of Psychology, Carnegie Mellon University
3Department of Psychology, University of Pittsburgh

 # Status of current dataset: # 
Data are currently under submission at Clinical Psychological Science. Publication information will be forthcoming as it becomes available.
