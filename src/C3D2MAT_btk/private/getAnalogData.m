function [AnalogData] = getAnalogData(h)   
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
    
    nFP=btkGetMetaData(h, 'FORCE_PLATFORM','USED');
    numberForcePlatform=nFP.info.values;
    
    fchannel=btkGetMetaData(h, 'FORCE_PLATFORM','CHANNEL');

catch
    numberForcePlatform=0;  %no force data
    fchannel.info.values=0;
    disp('Warning: No Force Plate Data: check AnalogData data!(Biodex trials not implemented yet!)')
end
 
% if forces are not present, all analog data will be extracted:
analogUsed=btkGetMetaData(h, 'ANALOG','USED');

nAnalogDataChannels=analogUsed.info.values;

UNITS=btkGetMetaData(h,'ANALOG','UNITS');
AnalogLabels = btkGetMetaData(h,'ANALOG','LABELS');

j=1;
for i=1:(nAnalogDataChannels)
    
    if  isempty(find(fchannel.info.values==i)) %if the analog channel is 
        %not a force channel
        AnalogDataLabels{j}=AnalogLabels.info.values{i};
        
        units{j}=UNITS.info.values{i};
        j=j+1;
    end
end

for i=1:length(AnalogDataLabels)
    AnalogRawData(:,i) = getanalogchannel(h, AnalogDataLabels{i});    
end

rate=btkGetMetaData(h,'ANALOG','RATE');

nStartFrame=btkGetFirstFrame(h);
nEndFrame =btkGetLastFrame(h);

%AnalogData struct
AnalogData.Rate = double(rate.info.values);
AnalogData.Units=units;
AnalogData.RawData=AnalogRawData;
AnalogData.Labels = AnalogDataLabels;
AnalogData.FirstFrame=nStartFrame;
AnalogData.LastFrame=nEndFrame;

