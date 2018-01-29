#PSTH_SPM

## Version and file locations
specify spm version
	
	spm_version	= '12';

location of spm 12 batch file

	matFileDir = '/data/luna/luna_j/GBW-0280_Neuro_Backup/0006_Prof_Vanduffel/examples/spm12/facebody_glm/';
	matFile    = 'batch_spm12_facebody_glm.mat';


location of nifti ROIs
ROIs should be a 1-0 mask in same volume space as SPM results
 
	clear roiFiles
	roiDir 		= [matFileDir,'/rois/'];
	roiFiles{1} 	= 'roi_test.nii';
	roiFiles{2} 	= 'roi_test2.nii';
	roiFiles{3} 	= 'roi_test3.nii';

location .eps files are saved

	printDir 	= [matFileDir,'/psth_results/'];
	
##Plotting specifications

time points pre and post onset to be included in PSTH (in TR)

	tpPre  = 10;
	tpPost = 50;

determines whether to flip for CBV

	flipCBV = 1;

colors of each condition in RGB values

	colorValues{1} = [.2 .2 .2]; 
	colorValues{2} = [.2 .2 .8];
	colorValues{3} = [.2 .8 .2];
	colorValues{4} = [.8 .2 .2]; 
	colorValues{5} = [.8 .2 .8]; 

HPF = high pass filter in seconds
TR   =  TR in seconds 
used to determine high pass filter

	HPF = 512;
	TR  = 2;

##parallelization
numClusters = number of processors to use for parallelization
if 1 then runs serial
	
	numClusters = 1;
	
##run
see EXAMPLE.m

	psth(matFileDir,matFile,roiDir,roiFiles,printDir,tpPre,tpPost,colorValues,HPF,numClusters,TR,flipCBV,spm_version)