function [EMG] = getEMG(itf)   
%getEMG
%Extraction of EMG from Analog Data

%WARNING!!!
%An ASSUMPTION is made, that SHOULD BE CONSIDERED:
%EMG signals are assumed to be immediately after the analog channel corresponding to the last force output channel: it's likely but
%this may not be true in general (Biodex trials is at the moment the only exception I know)!!
%This function read as EMG signals all data stored in analog channels after
%forces, i.e for Biodex trials it includes in EMG also Position and Torque
%which come after.
%the already available function getForcesIndex may be used in the future 
%(when common labels for the c3d files will be defined)to compute correct 
%indexes of EMG data

indexLabels = itf.GetParameterIndex('ANALOG','LABELS');
unitIndex = itf.GetParameterIndex('ANALOG', 'UNITS');

numberForcePlatform = itf.GetParameterValue(itf.GetParameterIndex('FORCE_PLATFORM','USED'),0);
fchannelIndex = itf.GetParameterIndex('FORCE_PLATFORM','CHANNEL');
% number of Force channels --> related to the force plate type (6 for type 1 and 2 but 8 for type 3)
nFchannels = itf.GetParameterLength(fchannelIndex);    %instead of numItems = numberForcePlatform*6;

lastFchannel=itf.GetParameterValue(fchannelIndex, nFchannels-1);
%fchannel contains the analog channel that corresponds to the last force plate output channel

%check if force data are present
if numberForcePlatform == 0
    disp('Warning: No Force Plate Data: check EMG data!(Biodex trials not implemented yet!)')
    offsetEMGLabels=0;
else
    %offsetEMGLabels = numberForcePlatform*6;%6: this number is related to the number of data for each platform (Fx Fy Fz Mx My Mz)
    offsetEMGLabels=lastFchannel;
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

nStartFrame = itf.GetVideoFrameHeader(0);
nEndFrame = itf.GetVideoFrameHeader(1);

%EMG struct
EMG.Rate = double(itf.GetParameterValue(rateIndex, 0));
EMG.Units=units;
EMG.RawData=EMGRawData;
EMG.Labels = EMGLabels;
EMG.FirstFrame=nStartFrame;
EMG.LastFrame=nEndFrame;