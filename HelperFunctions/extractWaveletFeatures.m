function [data, fileN] = extractWaveletFeatures(ds, sf, N, reference)
% Apply wavelet scattering defined by the scattering coeeficients <sf>
% to signal files from data store <ds> into a table <data>
% whose wavelet features are labelled given <reference>,
% and whose minimum number of samples is N

% initialize scattering feature with first signal file
featureT = table();
thisSignal = read(ds);     % read first signal(file)

% calculate the wavelet features for this signal
wFeatures = featureMatrix(sf,thisSignal.data(1:N),'Transform','Log');
scatterN = size(wFeatures,2);

% add the file name (which is called 'record_name' in the reference table
thisFile = array2table(string(repmat(thisSignal.filename,scatterN,1)));
thisFile.Properties.VariableNames = {'record_name'};
featureT = [thisFile, array2table(wFeatures')];
fileN = 1;         % processed one file so far

% loop over all remaining (signal) files in the data store
fprintf("Applying wavelet scattering (. = 100 signals): ");
while hasdata(ds)
    thisSignal = read(ds);
    wFeatures = featureMatrix(sf,thisSignal.data(1:N),'Transform','Log');
    thisFile = array2table(string(repmat(thisSignal.filename,scatterN,1)));
    thisFile.Properties.VariableNames = {'record_name'};
    
    % append scattering for <thisSignal> to feature table
    featureT = [featureT; [thisFile, array2table(wFeatures')]];
    
    % track progress
    fileN = fileN + 1;
    if(mod(fileN,100)==0) 
        fprintf(".");
    end
   
end
fprintf(" done.\n");

% add "class" label from reference table by joining on record_name
reference.record_name = string(reference.record_name);
data = innerjoin(featureT,reference);
data.Properties.VariableNames(end) = {'class'};  


end
