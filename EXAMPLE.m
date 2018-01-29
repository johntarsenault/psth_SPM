% specify spm version
spm_version	= '12';

%location of spm batch file
matFileDir = '/data/luna/luna_j/GBW-0280_Neuro_Backup/0006_Prof_Vanduffel/examples/spm12/facebody_glm/';
matFile    = 'batch_spm12_facebody_glm.mat';

%location of nifti ROIs
%ROIs should be a 1-0 mask in same volume space 
clear roiFiles
roiDir 		= [matFileDir,'/rois/'];
roiFiles{1} 	= 'roi_test.nii';
roiFiles{2} 	= 'roi_test2.nii';
roiFiles{3} 	= 'roi_test3.nii';

%location .eps files are printed
printDir 	= [matFileDir,'/psth_results/'];


%colors of each condition in RGB values
colorValues{1} 	= [.2 .2 .2]; 
colorValues{2} 	= [.2 .2 .8];
colorValues{3} 	= [.2 .8 .2];
colorValues{4} 	= [.8 .2 .2]; 
colorValues{5} 	= [.8 .2 .8]; 
colorValues{6} 	= [.8 .8 .2];
colorValues{7} 	= [.2 .8 .8]; 
colorValues{8} 	= [.6 .6 .6]; 

%time points pre and post onset in TRs
%to be included in PSTH
tpPre  	= 10;
tpPost 	= 50;

%determines whether to flip for CBV
flipCBV = 1;

%high pass filter in seconds and TR in seconds 
%used to determine high pass filter
HPF 	= 512;
TR  	= 2;

%number of processors to use for parallelization
%if numClusters = 1 then runs serial
numClusters = 1;

%run
psth(matFileDir,matFile,roiDir,roiFiles,printDir,tpPre,tpPost,colorValues,HPF,numClusters,TR,flipCBV,spm_version)
