function [PSTH_PerRunOverall mean_PSTH_PerRunOverall  sem_PSTH_PerRunOverall var_PSTH_PerRunOverall] = combinePSTH_PerRun(PSTH_PerRun)
    
    clear PSTH_PerRunOverall
    PSTH_PerRunOverall = {};
    mean_PSTH_PerRunOverall = {};
    sem_PSTH_PerRunOverall = {};

    runs        = length(PSTH_PerRun);
    rois        = length(PSTH_PerRun{1}.roi);
    numConds    = length(PSTH_PerRun{1}.roi{1});

    %loop through rois
    for l = 1:rois
        
        %loop through runs
        for i = 1:numConds
            
            PSTH_PerRunOverall{l}{i} = [];
            for j = 1:runs
                PSTH_PerRunOverall{l}{i} = [PSTH_PerRunOverall{l}{i}  PSTH_PerRun{j}.roi{l}{i}];   
            end
                mean_PSTH_PerRunOverall{l}{i} = nanmean(PSTH_PerRunOverall{l}{i},2);
                sem_PSTH_PerRunOverall{l}{i} = nanstd(PSTH_PerRunOverall{l}{i},[],2)/sqrt(size(PSTH_PerRunOverall{l}{i},2));
                var_PSTH_PerRunOverall{l}{i} = nanvar(PSTH_PerRunOverall{l}{i},[],2);
        end
    end