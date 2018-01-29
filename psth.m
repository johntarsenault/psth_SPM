function psth(matFileDir,matFile,roiDir,roiFiles,printDir,tpPre,tpPost,colorValues,HPF,numClusters,TR,flipCBV,spm_version)

switch spm_version
	case '12'
		psth_SPM_12(matFileDir,matFile,roiDir,roiFiles,printDir,tpPre,tpPost,colorValues,HPF,numClusters,TR,flipCBV);
	otherwise
		error('this version of SPM is not supported.  Please add!');
	end

