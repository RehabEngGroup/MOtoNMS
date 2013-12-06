function [AnalogData] = getAnalogData(itf)   
%getAnalogData
%Extraction of Analog Data
%This function reads all data stored in analog channels after forces (EMG,
%Biodex data, Position and Torque,etc.)

% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2013 Alice Mantoan, Monica Reggiani
%
% MOtoNMS is free software: you can redistribute it and/or modify it under 
% the terms of the GNU General Public License as published by the Free 
% Software Foundation, either version 3 of the License, or (at your option)
% any later version.
%
% Matlab MOtion data elaboration TOolbox for NeuroMusculoSkeletal applications
% is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
% without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
% PARTICULAR PURPOSE.  See the GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along 
% with MOtoNMS.  If not, see <http://www.gnu.org/licenses/>.
%
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
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
    disp('Warning: No Force Plate Data: check AnalogData data!(Biodex trials not implemented yet!)')
    offsetAnalogDataLabels=0;
else
    %offsetAnalogDataLabels = numberForcePlatform*6;%6: this number is related to the number of data for each platform (Fx Fy Fz Mx My Mz)
    offsetAnalogDataLabels=lastFchannel;
end

% if forces are not present, all analog data will be extracted:
nAnalogDataChannels = itf.GetParameterDimension(indexLabels,1)- offsetAnalogDataLabels;

for i=1:(nAnalogDataChannels)
    AnalogDataLabels{i} = itf.GetParameterValue(itf.GetParameterIndex('ANALOG','LABELS'),(i+offsetAnalogDataLabels-1));
    
    %it may be necessary to eliminate spaces from the Labels 
    %AnalogDataLabelsStruct{i} = regexprep(AnalogDataLabels{i}, ' ', ''); 
    
    units{i} = itf.GetParameterValue(unitIndex, i+offsetAnalogDataLabels-1);
end

for i=1:length(AnalogDataLabels)
    AnalogRawData(:,i) = getanalogchannel(itf, AnalogDataLabels{i});    
end

rateIndex = itf.GetParameterIndex('ANALOG', 'RATE');

nStartFrame = itf.GetVideoFrameHeader(0);
nEndFrame = itf.GetVideoFrameHeader(1);

%AnalogData struct
AnalogData.Rate = double(itf.GetParameterValue(rateIndex, 0));
AnalogData.Units=units;
AnalogData.RawData=AnalogRawData;
AnalogData.Labels = AnalogDataLabels;
AnalogData.FirstFrame=nStartFrame;
AnalogData.LastFrame=nEndFrame;