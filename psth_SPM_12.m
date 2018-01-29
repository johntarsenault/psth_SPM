function psth_SPM_12(matFileDir,matFile,roiDir,roiFiles,printDir,tpPre,tpPost,colorValues,HPF,numClusters,TR,flipCBV)

% example code
% matFileDir = '/mnt/.autofs/storage/gbw-s-neu01_fmri-monkey-03/PROJECT/John/code/fmri_basics/psth/';
% matFile    = 'batch_Tank_121317_17h40_no_motion_regressor.mat';
% 
% roiDir = matFileDir;
% roiFiles{1} = 'roi_test.nii';
% roiFiles{2} = 'roi_test_2.nii';
 

% printDir = matFileDir;

% %time points pre and post onset in TRs
% example:
% tpPre  = 10;
% tpPost = 50;
% 
% colorValues{1} = [.2 .2 .2]; 
% colorValues{2} = [.2 .2 .8];
% colorValues{3} = [.2 .8 .2];
% colorValues{4} = [.8 .2 .2]; 
% colorValues{5} = [.8 .2 .8]; 
% 
% HPF = 512;
% 
% numClusters = 8;
% TR=2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%load spm files 
load([matFileDir,matFile]);

%get PSTHs - parallel or serial
%format: 
%PSTH_PerRun{run#}.roi{roi#}{condition#} = [timePoints x presentations]
if numClusters > 1
    [PSTH_PerRun PSTH_label] = determinePSTH_PerRun_PF(matlabbatch,roiDir,roiFiles,TR,tpPre,tpPost,HPF,numClusters,flipCBV);
else
    [PSTH_PerRun PSTH_label] = determinePSTH_PerRun_Serial(matlabbatch,roiDir,roiFiles,TR,tpPre,tpPost,HPF,numClusters,flipCBV);
end



%get mean and sem for individual ROIs
[PSTH_PerRunOverall mean_PSTH_PerRunOverall  sem_PSTH_PerRunOverall] = combinePSTH_PerRun(PSTH_PerRun);




%loop through each ROI
for i = 1:length(roiFiles)
    %plot psth from each roi
    plotPSTH_perROI(mean_PSTH_PerRunOverall{i},sem_PSTH_PerRunOverall{i},PSTH_label,colorValues,tpPre,tpPost,printDir,roiFiles{i});

    %save psth data in matFile
    clear psth
    psth.allData  = PSTH_PerRunOverall;
    psth.meanData = mean_PSTH_PerRunOverall;
    psth.semData  = sem_PSTH_PerRunOverall;
    matFileName = [printDir,roiFiles{i}(1:end-4),'.mat'];
    save(matFileName,'psth')
end
