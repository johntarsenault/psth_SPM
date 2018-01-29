function [PSTH_PerRun,PSTH_label] = determinePSTH_PerRun_PF(matlabbatch,ROIDir,ROINames,TR,tpPre,tpPost,HPF,numClusters,flipCBV)

runs = length(matlabbatch{1}.spm.stats.fmri_spec.sess);
currentImageName = cell(runs,1);
currentMatFile   = cell(runs,1);
psc_Current      = cell(runs,1);
PSTH_PerRun      = cell(runs,1);
PSTH_label       = cell(runs,1);

counter =  0;
% loop through every run; parralel or serial depending on number of
% clusters
    parpool(numClusters);
    parfor i = 1:length(matlabbatch{1}.spm.stats.fmri_spec.sess)

    %load the current 4D volume
    currentImageName{i} = matlabbatch{1}.spm.stats.fmri_spec.sess(i).scans{1}(1:end-2);
    
    %load the onsets of events
    currentMatFile{i} = load(matlabbatch{1}.spm.stats.fmri_spec.sess(i).multi{1});
       
    %find the mean PSC timecourse of current 4D in the current roi
    psc_Current{i} = pctSigChange_multi(currentImageName{i},ROIDir,ROINames,TR,HPF,flipCBV);
     
    %make a PSTH
    PSTH_PerRun{i} = getPSTH_ROI(psc_Current{i},currentMatFile{i},TR,tpPre,tpPost);
    
    %Label each of the PSTHs
    PSTH_label{i} = currentMatFile{i}.names; 
    
    end

    delete(gcp('nocreate'));


end
