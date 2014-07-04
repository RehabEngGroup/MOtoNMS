function [foldersPaths]=foldersPathsDefinition (inputPath,trialName,configFilePath)
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
    inputFilePath=inputPath;
       
else

    [fileName,inputFilePath] = uigetfile([ filesep '*.c3d'],'Select .c3d input file for static elaboration', pwd);
    
    trialName = regexprep(regexprep((regexprep(fileName, ' ' , '')), '-',''), '.c3d', '');
    
end

%Output folder: Elaborated Data
ElaboratedDataPath=regexprep(inputFilePath, 'InputData', 'ElaboratedData');

if exist(ElaboratedDataPath,'dir') ~= 7
    mkdir (ElaboratedDataPath);
end

%Session Data folder
sessionDataFolder=[ElaboratedDataPath 'sessionData' filesep];

matDataPath=[sessionDataFolder trialName ];


staticElaborationsPath=[ElaboratedDataPath 'staticElaborations' filesep];

if exist(staticElaborationsPath,'dir') ~= 7
    mkdir (staticElaborationsPath);
end

%Elaboration folder
if nargin>2
    
    elaborationPath=configFilePath;
else
        
    %ask for an identificator for this specific elaboration
    IDstaticElaboration = cell2mat(inputdlg('Insert New Elaboration Identifier'));
    
    elaborationPath=[staticElaborationsPath trialName filesep IDstaticElaboration filesep];
    
    if exist(elaborationPath,'dir') ~= 7
        mkdir (elaborationPath);
    end
end


foldersPaths.inputFile=inputFilePath;
foldersPaths.elaboratedData=ElaboratedDataPath;
foldersPaths.matData=matDataPath;
foldersPaths.staticElaborations=staticElaborationsPath;
foldersPaths.elaboration=elaborationPath;


