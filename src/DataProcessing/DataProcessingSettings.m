function [foldersPath,parameters]= DataProcessingSettings(ElaborationFilePath)
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
try
    elaboration=xml_read([ElaborationFilePath filesep 'elaboration.xml']);
    disp(['Running ' ElaborationFilePath filesep 'elaboration.xml'])
catch
    disp('elaboration.xml file not fuond in the specified path')
end

%acquisition.xml file path reconstruction
i=strfind(ElaborationFilePath,'ElaboratedData');

acquisitionPath=[ElaborationFilePath(1:(i-1)) elaboration.FolderName(3:end)];

%Acquisition Info: load acquisition.xml
acquisitionInfo=xml_read([acquisitionPath filesep 'acquisition.xml']);

%Folders Definition
foldersPath=foldersDefinition(acquisitionPath,ElaborationFilePath);

%Parameters.mat file Generation
parameters=parametersGeneration(elaboration,acquisitionInfo,foldersPath);