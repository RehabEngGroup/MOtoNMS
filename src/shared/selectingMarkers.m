function markerstrc = selectingMarkers(MarkersList,MLabels,markers)
%MarkersList: list of markers to print in the trc file
%MLabels: list of markers in the c3d file
%markers: struct of markers trajectories [nFrames x nMarkers*(XYZ)], where
%nMarkers corrisponds to the initial MLabels

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

for i=1:length(MarkersList)
    j=MarkersList(i);
    
    z=strmatch(j,MLabels,'exact');
    
    if isempty(z)
        disp('Unfound marker: ')
        disp(j)
        error(['Marker to be written in the .trc file not found in the data. Check labeled data or your selection of markers for the trc file saved in the elaboration.xml'])
        
    else
        if i==1
            indexMarkerLabels=[z];
        else
            indexMarkerLabels=[indexMarkerLabels;z];
        end
    end
end

newMarkerLabels=[MLabels(indexMarkerLabels)];
   
markerstrc=[];

for i=1: length(newMarkerLabels)
    
    newindex=(indexMarkerLabels(i)-1)*3+1;
    markerstrc=[markerstrc markers(:,newindex:newindex+2)];
end




