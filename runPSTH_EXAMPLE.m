%location of spm 12 batch file
matFileDir = '/mnt/.autofs/storage/gbw-s-neu01_fmri-monkey-03/PROJECT/John/code/fmri_basics/psth/';
matFile    = 'batch_Tank_121317_17h40_no_motion_regressor.mat';

%location of nifti ROIs
%ROIs should be a 1-0 mask in same volume space 
roiDir = matFileDir;
roiFiles{1} = 'roi_test.nii';
roiFiles{2} = 'roi_test_2.nii';

%location .eps files are printed
printDir = matFileDir;

%time points pre and post onset in TRs
%to be included in PSTH
tpPre  = 10;
tpPost = 50;

%colors of each condition
colorValues{1} = [.2 .2 .2]; 
colorValues{2} = [.2 .2 .8];
colorValues{3} = [.2 .8 .2];
colorValues{4} = [.8 .2 .2]; 
colorValues{5} = [.8 .2 .8]; 

%high pass filter in seconds and TR in seconds 
%used to determine high pass filter
HPF = 512;
TR=2;

%number of processors to use for parallelization
%if 1 then runs serial
numClusters = 1;

psth(matFileDir,matFile,roiDir,roiFiles,printDir,tpPre,tpPost,colorValues,HPF,numClusters,TR)