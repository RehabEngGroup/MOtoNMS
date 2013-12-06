function FPdata = getForcePlatesData(itf)
%getForcePlatesData
%Extraction of FPdata and Moments from Analog Data

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
 numberForcePlatform =  itf.GetParameterValue( itf.GetParameterIndex('FORCE_PLATFORM', 'USED'),0);
 
 fchannelIndex = itf.GetParameterIndex('FORCE_PLATFORM','CHANNEL');
% From C3D User Guide: 
% The C3D file format allows force platform information to be recorded in any analog 
% channel. There is no requirement that force platform data be ordered in any specific
% way in the recorded analog data as the FORCE_PLATFORM:CHANNEL parameter is
% used to specify the correspondence between recorded analog data channels (1, 2, 3
% etc) and force platform channels (e.g. Fx, Fy, Mz).

% number of Force channels --> related to the force plate type (6 for type 1 and 2 but 8 for type 3)
 nFchannels = itf.GetParameterLength(fchannelIndex);    %instead of numItems = numberForcePlatform*6;
 
 unitIndex = itf.GetParameterIndex('ANALOG', 'UNITS');

 if nFchannels > 0  %if FPdata are present
     
     for i = 1 : nFchannels,
         %retrieve analog channel corresponding to force plate output channel
         %this allow taking into account more than 6 force channels (like for fp of type 3)
         %but also if force channels do not correspond in order to the analog
         %channels (e.g 7th analog channel empty instead having Fx2)
         fchannel=itf.GetParameterValue(fchannelIndex, i-1);
         %fchannel contains the analog channel that corresponds to the i-1 force plate output channel
         
         %Labels{i} =
         %itf.GetParameterValue(itf.GetParameterIndex('ANALOG','LABELS'), i-1); this was for a sequential order (1: numberForcePlatform*6)
         Labels{i} = itf.GetParameterValue(itf.GetParameterIndex('ANALOG','LABELS'), fchannel-1);  %here the order does not matter
         
         %units{i}= itf.GetParameterValue(unitIndex, i-1);
         units{i}= itf.GetParameterValue(unitIndex, fchannel-1);
         
         Values(:,i) = getanalogchannel(itf, Labels{i});
         
     end
     
     rateIndex = itf.GetParameterIndex('ANALOG', 'RATE');
     
     nStartFrame = itf.GetVideoFrameHeader(0);
     nEndFrame = itf.GetVideoFrameHeader(1);
     
     FPdata.Rate = itf.GetParameterValue(rateIndex, 0);
     FPdata.Units=units;
     FPdata.RawData=Values;
     FPdata.Labels=Labels;
     
     FPdata.FirstFrame=nStartFrame;
     FPdata.LastFrame=nEndFrame;
     
 else  %Biodex trials for example
     FPdata=[];
     disp('Force Platform Channels empty')
 end

