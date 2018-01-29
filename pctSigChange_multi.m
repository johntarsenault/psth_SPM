function PctSigChange_currentTimeSeries = pctSigChange_multi(currentImageName,ROIDir,ROINames,TR,HPF,flipCBV)
addpath /fmri/apps/freesurfer-5.3.0/matlab/
        
%specify window size (in TR) for baseline determination percent signal change calc
windowSize = 100;

   %load current time-series image
   currentImage= MRIread(currentImageName);
   
   %determine size of time-series
   [sizeX sizeY sizeZ sizeT] = size(currentImage.vol);
    
   %break 4D volume into 3D volumes
   for i = 1:sizeT
        currentVolume{i} = currentImage.vol(:,:,:,i);
   end
   
   %loop through all ROIs and find high pass filtered PSTH
   for i = 1:length(ROINames)
   
        %load current ROI
        currentROI = MRIread([ROIDir,ROINames{i}]);
        currentROI_indices = find(currentROI.vol==1);

     for j = 1:sizeT
        %grabbing mean raw data from the ROI
        currentRawTimeSeries{i}(j) = nanmean(currentVolume{j}(currentROI_indices));
     end
        
        %high pass filter the time-series; but says lowpass for some fucking reason
        %lowPass_currentTimeSeries{i} = detrend(currentRawTimeSeries{i}');
        lowPass_currentTimeSeries{i} =  danteHighPassFilter(currentRawTimeSeries{i}',TR,HPF);
        lowPass_currentTimeSeries{i} = lowPass_currentTimeSeries{i} - mean(lowPass_currentTimeSeries{i}) + mean(currentRawTimeSeries{i});
        
        %determine PSC from low pass filtered time-series
        baseline_currentTimeSeries{i}=moving(lowPass_currentTimeSeries{i},windowSize);
        PctSigChange_currentTimeSeries{i} = ((lowPass_currentTimeSeries{i}-baseline_currentTimeSeries{i})./baseline_currentTimeSeries{i})*100;
   end
   
   %flip if MION CBV measured
   if flipCBV
       PctSigChange_currentTimeSeries = cellfun(@(x) x*-1,PctSigChange_currentTimeSeries,'UniformOutput',0);
   end
