% adapted from code originally written by Jeanette Mumford 2016

function p = run_ppi(subject,featname,run_num)
% featname is one of either: sepworry_NOworry, sepworry_ONLYworry

%Add SPM to the path
addpath /home/westbroo/spm12
addpath /home/westbroo/Worry_and_Mindfulness/Scripts/PPI/fslppi

%First you need to tell Matlab where to look for the ppi stuff.
%There's a copy of spm_PEB.m in here but I don't think it matters if it
%uses the spm5 version or this one.  I checked and they seem mostly identical

% The path to the feat directory
 featdir=['/mnt/Worry_and_Mindfulness/Subjects/',num2str(subject),'/func/WM/model/level1/',...
     'run',num2str(run_num),'_',featname,'.feat'];

%the path to the seed voxel.  You'll need to make this file on your
% own, probably using fslmeants with your ROI mask for the seed.

voi=['/mnt/Worry_and_Mindfulness/Subjects/',num2str(subject),...
    '/func/WM/model/PPI/ts.PCC_MNI_nudge.run',num2str(run_num),'.1D'];

%the call works as follows: featdir, voi, contrast that picks out the
% regressor you're interetested in and the last number is a flag where
% 1 plots the output and 0 doesn't.  I've set it at 1 so you can see
% what the code makes


%I need to run it twice, once for each regressor, since I'm interested
%in the [1 -1] PPI interaction, I must run [1 0] and [0 1] separately.

% These are the codes for the contrasts below, which get convolved with the seed timeseries
[A1 B1]=fsl_ppi(featdir, voi, [0 0 0 1 0 0 0 0 0], 0);
[A2 B2]=fsl_ppi(featdir, voi, [0 0 0 0 1 0 0 0 0 0 0], 0);
[A3 B3]=fsl_ppi(featdir, voi, [0 0 0 1 0 0 0 0 0 0 0], 0);
[A4 B4]=fsl_ppi(featdir, voi, [0 0 0 0 0 1 0 0 0 0 0], 0);
[A5 B5]=fsl_ppi(featdir, voi, [0 0 0 0 0 1 0 0 0 0 0], 0);
[A6 B6]=fsl_ppi(featdir, voi, [0 0 0 0 1 0 0 0 0 0 0], 0);

%Nothing has been saved out, but you'll want to save out the
% regressors that will be fed into your PPI feat

%Your feat model will contain everything you had in it originally, but
% now you'll add the seed (you already saved that) and your 2 PPI
% regressors

%These are already convolved, so use 1 column format with *NO* HRF
%convolution in FSL.  
ppi_01=A1.ppi;
ppi_02=A2.ppi;
ppi_03=A3.ppi;
ppi_04=A4.ppi;
ppi_05=A5.ppi;
ppi_06=A6.ppi;

%you might want to use a better path, this will just stick the
%regressor in the feat directory

save(['/mnt/Worry_and_Mindfulness/Subjects/',num2str(subject),'/func/WM/model/PPI/',...
    'AcceptSuppress_pos_ppi_run',num2str(run_num),'.txt'], 'ppi_01', '-ascii')
save(['/mnt/Worry_and_Mindfulness/Subjects/',num2str(subject),'/func/WM/model/PPI/',...
    'AcceptSuppress_neg_ppi_run',num2str(run_num),'.txt'], 'ppi_02', '-ascii')
save(['/mnt/Worry_and_Mindfulness/Subjects/',num2str(subject),'/func/WM/model/PPI/',...
    'AcceptFA_pos_ppi_run',num2str(run_num),'.txt'], 'ppi_03', '-ascii')
save(['/mnt/Worry_and_Mindfulness/Subjects/',num2str(subject),'/func/WM/model/PPI/',...
    'AcceptFA_neg_ppi_run',num2str(run_num),'.txt'], 'ppi_04', '-ascii')
save(['/mnt/Worry_and_Mindfulness/Subjects/',num2str(subject),'/func/WM/model/PPI/',...
    'FASuppress_pos_ppi_run',num2str(run_num),'.txt'], 'ppi_05', '-ascii')
save(['/mnt/Worry_and_Mindfulness/Subjects/',num2str(subject),'/func/WM/model/PPI/',...
    'FASuppress_neg_ppi_run',num2str(run_num),'.txt'], 'ppi_06', '-ascii')

