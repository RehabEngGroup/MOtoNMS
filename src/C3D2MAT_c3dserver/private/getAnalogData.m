function [AnalogData] = getAnalogData(itf)   
%getAnalogData
%Extraction of Analog Data
%This function reads all data stored in analog channels that are not forces
%(EMG, Biodex data, Position and Torque,etc.)

% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2012-2014 Alice Mantoan, Monica Reggiani
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

try % to extract data even if force platform data are not stored in the c3d
    fchannelIndex = itf.GetParameterIndex('FORCE_PLATFORM','CHANNEL');
    
    % number of Force channels --> related to the force plate type (6 for type 1 and 2 but 8 for type 3)
    nFchannels = itf.GetParameterLength(fchannelIndex);    
    
catch
    nFchannels=0; %No force platform
    fchannelIndex=-1;
end

if nFchannels > 0  %check if force data are present
    
    for i = 1 : nFchannels,

        Fchannels(i)=itf.GetParameterValue(fchannelIndex, i-1);
        %Fchannels contains the analog channels with force data      
    end
else
    Fchannels=[];
end

indexLabels = itf.GetParameterIndex('ANALOG','LABELS');
unitIndex = itf.GetParameterIndex('ANALOG', 'UNITS');

% if forces are not present, all analog data will be extracted:
nAnalogDataChannels = itf.GetParameterDimension(indexLabels,1);

j=1;
for i=1:(nAnalogDataChannels)
    
    if isempty(find(Fchannels==i)) %if the i-th channel is not a force channel
        
        AnalogDataLabels{j} = itf.GetParameterValue(itf.GetParameterIndex('ANALOG','LABELS'),(i-1));
        
        units{j} = itf.GetParameterValue(unitIndex, i-1);
        j=j+1;
    end
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