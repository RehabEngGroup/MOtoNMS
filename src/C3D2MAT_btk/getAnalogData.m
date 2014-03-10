function [AnalogData] = getAnalogData(h)   
%getAnalogData
%Extraction of Analog Data
%This function reads all data stored in analog channels after forces (EMG,
%Biodex data, Position and Torque,etc.)

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
    
    % number of Force channels --> related to the force plate type (6 for type 1 and 2 but 8 for type 3)
    nFchannel= size(fchannel.info.values,1)*size(fchannel.info.values,2);
    
    lastFchannel=fchannel.info.values(end,end);
    %lastFchannel contains the analog channel that corresponds to the last force plate output channel
catch
    numberForcePlatform=0;
end

%check if force data are present
if numberForcePlatform == 0
    disp('Warning: No Force Plate Data: check AnalogData data!(Biodex trials not implemented yet!)')
    offsetAnalogDataLabels=0;
else
    %offsetAnalogDataLabels = numberForcePlatform*6;%6: this number is related to the number of data for each platform (Fx Fy Fz Mx My Mz)
    offsetAnalogDataLabels=lastFchannel;
end

% if forces are not present, all analog data will be extracted:
analogUsed=btkGetMetaData(h, 'ANALOG','USED');
nAnalogDataChannels=analogUsed.info.values-offsetAnalogDataLabels;

UNITS=btkGetMetaData(h,'ANALOG','UNITS');
AnalogLabels = btkGetMetaData(h,'ANALOG','LABELS');

for i=1:(nAnalogDataChannels)
    
    AnalogDataLabels{i}=AnalogLabels.info.values{i+offsetAnalogDataLabels};
 
    units{i}=UNITS.info.values{i+offsetAnalogDataLabels};
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

