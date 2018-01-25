function PSTH_Run = getPSTH_ROI(PSC,currentMatFile,TR,tpPre,tpPost)


%loop through every roi and get per run PSTH
for k = 1:length(PSC)
    PSTH_Run.roi{k} = getPSTH_Run_ROI(PSC{k},currentMatFile,TR,tpPre,tpPost);
end
end

%for the given run and roi cut out PSTH for each stimulus condition
function PSTH_Run = getPSTH_Run_ROI(PSC,currentMatFile,TR,tpPre,tpPost)
    clear PSTH_Run
    PSTH_Run = {};
    
    %loop through each condition
    for i = 1:length(currentMatFile.onsets)
        
            %for each condition build matrix (columns = number of
            %presentations; rows = number of tpPre + tpPost + 1)
            PSTH_Run{i} =  [];
            for j = 1:length(currentMatFile.onsets{i})
                lengthOfTimeSeries = length(PSC);
                currentPSTH = getPSTH_curentOnset(currentMatFile.onsets{i}(j),TR,tpPre,tpPost,PSC,lengthOfTimeSeries);
                PSTH_Run{i} = [PSTH_Run{i} currentPSTH];        
            end
    end

end

%find PSTH for one presentation of one condition from timewindow  tpPre to tpPost
function currentPSTH = getPSTH_curentOnset(currentOnset,TR,tpPre,tpPost,PSC,lengthOfTimeSeries)
            %build nan filled timeseries of current time window
            currentPSTH = NaN(tpPre+tpPost+1,1);
            
            %find time points in time window
            timePointsToUse = floor((currentOnset-tpPre)):floor((currentOnset+tpPost));
            
            %loop through timepoints and fill if timepoints exist
            for k = 1:length(timePointsToUse)
                if timePointsToUse(k)>0 && timePointsToUse(k)<=lengthOfTimeSeries
                    currentPSTH(k) = PSC(timePointsToUse(k));
                end
            end
end


