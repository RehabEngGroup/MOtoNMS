function [EMG] = getEMG(itf)   
%getEMG
%Extraction of EMG from Analog Data

%WARNING!!!
%An ASSUMPTION is made, that SHOULD BE CONSIDERED:
%Forces are assumed to be in the first channels and EMG signals after, but
%this may not be true in general!!
%This function does not work if forces are not present in the c3d file 
%(BIODEX files) or if they are not in the first channels
%the already available function getForcesIndex may be used in the future 
%(when common labels for the c3d files will be defined)to compute correct 
%indexes of EMG data

indexLabels = itf.GetParameterIndex('ANALOG','LABELS');
unitIndex = itf.GetParameterIndex('ANALOG', 'UNITS');

numberForcePlatform = itf.GetParameterValue(itf.GetParameterIndex('FORCE_PLATFORM','USED'),0);

%check if force data are present
if numberForcePlatform == 0
    disp('Warning: No Force Plate Data')
    offsetEMGLabels=0;
else
    offsetEMGLabels = numberForcePlatform*6;%6: this number is related to the number of data for each platform (Fx Fy Fz Mx My Mz)
end

% if forces are not present, all analog data will be extracted: this MUST
% be corrected in the future!
nEMGChannels = itf.GetParameterDimension(indexLabels,1)- offsetEMGLabels;

for i=1:(nEMGChannels)
    EMGLabels{i} = itf.GetParameterValue(itf.GetParameterIndex('ANALOG','LABELS'),(i+offsetEMGLabels-1));
    
    %EMG LABELS: MUST BE STANDARDIZED
    %for the moment,it may be necessary to eliminate spaces from the Labels 
    %EMGLabelsStruct{i} = regexprep(EMGLabels{i}, ' ', ''); 
    
    units{i} = itf.GetParameterValue(unitIndex, i+offsetEMGLabels-1);
end

for i=1:length(EMGLabels)
    EMGRawData(:,i) = getanalogchannel(itf, EMGLabels{i});    
end

rateIndex = itf.GetParameterIndex('ANALOG', 'RATE');

%EMG struct
EMG.Rate = double(itf.GetParameterValue(rateIndex, 0));
EMG.Units=units;
EMG.RawData=EMGRawData;
EMG.Labels = EMGLabels;