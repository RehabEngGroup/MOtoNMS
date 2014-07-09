function [data, labels, frames, units] = loadMatData (sessionDataFolder, trialsList, dataType)
%
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

for k=1: length(trialsList)
    
    trialMatFolder=cell2mat([sessionDataFolder  trialsList(k) filesep]);
    
    load([trialMatFolder dataType '.mat']);
    
    eval(['data{k}=double(' dataType '.RawData);']);
    
    eval(['labels{k}=' dataType '.Labels;']);
    
    eval(['frames{k}.First=' dataType '.FirstFrame;']);
    eval(['frames{k}.Last=' dataType '.LastFrame;']);
    
    %check markers units: if == 'mm' ok, else convert
    if strcmp(dataType,'Markers')
        eval(['data{k} = markersUnitsCheck(' dataType ');' ]);
    end
    
    eval(['units{k}=' dataType '.Units;']);
    
end