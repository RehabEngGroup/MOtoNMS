function  [inputMarkersNames,inputMarkersData]= JCmarkersDefintion(input,protocolMLabels,markers,jointTag)
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

if isfield(input,'MarkerNames') 
    
    for i=1:length(input.MarkerNames.Marker)
        
        inputMarkersNames{i}=input.MarkerNames.Marker(i);
        
        inputMarkersData{i}=selectingMarkers(inputMarkersNames{i},protocolMLabels,markers{1}(:,1:length(protocolMLabels)*3));
        
        if isempty(inputMarkersData{i})
            error(['Marker for ' jointTag ' JC computation not found: check markers labels defined in the JC method xml file with the markers set'])
        end
    end
    
else
    disp(['No markers are specified among input for ' jointTag ' JointCenter computation in static.xml file'])
    inputMarkersData=[];
    inputMarkersNames=[];
end
