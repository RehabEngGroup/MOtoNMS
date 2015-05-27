function [foldersPath]=foldersDefinition (initialPath,ElaborationFilePath)
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
if nargin>0
    %when the path is available is not necessary to ask the user
    inputDataPath=initialPath;
       
else
    %Input data folder manual selection for the user interface
    inputDataPath = uigetdir('Select your input data folder');
    
end

%Output folder: Elaborated Data
outputsFolderPath=regexprep(inputDataPath, 'InputData', 'ElaboratedData');

if exist(outputsFolderPath,'dir') ~= 7
    mkdir (outputsFolderPath);
end

%Session Data folder
sessionDataFolder=[outputsFolderPath filesep 'sessionData' filesep];


%Elaboration folder
if nargin>1
    
    elaborationFolderPath=ElaborationFilePath;
else
        
    %ask for an identificator for this specific elaboration
    IDelaboration = cell2mat(inputdlg('Insert New Elaboration Identifier'));
    
    %elaborationFolderPath=[outputsFolderPath '\elaboration_' IDelaboration '\'];
    elaborationFolderPath=[outputsFolderPath filesep 'dynamicElaborations' filesep IDelaboration filesep];
    
    if exist(elaborationFolderPath,'dir') ~= 7
        mkdir (elaborationFolderPath);
    end
end

%struct with all folder paths

foldersPath.inputData=inputDataPath;
foldersPath.outputData=outputsFolderPath;
foldersPath.sessionData=sessionDataFolder;
foldersPath.elaboration=elaborationFolderPath;
