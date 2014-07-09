 function Markers = get3dPointsData(h)
% get3dPointsData - returns structure with markers data

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

[markers, markersInfo] = btkGetMarkers(h);

Labels=fieldnames(markers);
 
Values=[];

for i = 1 : length(Labels)
    
   XYZ= eval(['markers.' Labels{i}]);
  
   Values=[Values XYZ];
        
end 

nStartFrame=btkGetFirstFrame(h);
nEndFrame =btkGetLastFrame(h);


Markers.Rate=markersInfo.frequency;
Markers.Units=markersInfo.units.ALLMARKERS;

Markers.RawData=Values;
Markers.Labels=Labels';

Markers.FirstFrame=nStartFrame;
Markers.LastFrame=nEndFrame;

