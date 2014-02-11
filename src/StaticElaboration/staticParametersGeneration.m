%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               MOtoNMS                                   %
%                MATLAB MOTION DATA ELABORATION TOOLBOX                   %
%                 FOR NEUROMUSCULOSKELETAL APPLICATIONS                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convert static.xml file into a parameter.mat struct for elaboration 
%
% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
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

function staticParameters = staticParametersGeneration(staticSettings,acquisitionInfo,foldersPaths,varargin)
%staticParameters struct Definition

%Data needed for oldParameters

%Fcut
if isfield(staticSettings,'Fcut')
    staticParameters.Fcut{1}=num2str(staticSettings.Fcut);
end

try
    %JC Computation: no changes from static.xml file
    staticParameters.JCcomputation=staticSettings.JCcomputation;
    
    %trcMarkersList
    Markers=staticSettings.trcMarkers;
    trcMarkersList=textscan(Markers, '%s');
    trcMarkersList=trcMarkersList{1};
    
    staticParameters.trcMarkersList=trcMarkersList;
    
catch
    msgbox('Information missing to run the code: check static.xml file with its .xsd!','Static Parameters Generation','error');
end

if nargin>1  %Parameters not needed for oldParameters
        
    %Parameters definition from acquisition.xml file
    
    globalReferenceSystem= acquisitionInfo.Laboratory.CoordinateSystemOrientation;
    
    globalToOpenSimRotations=globalToOpenSimRotParametersCreator(globalReferenceSystem);

    staticParameters.globalToOpenSimRotations=globalToOpenSimRotations;
   
    save ([foldersPaths.elaboration '\staticParameters.mat'], 'staticParameters')
end

save_to_base(1)


