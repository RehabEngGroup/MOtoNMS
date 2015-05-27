%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               MOtoNMS                                   %
%                MATLAB MOTION DATA ELABORATION TOOLBOX                   %
%                 FOR NEUROMUSCULOSKELETAL APPLICATIONS                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Read a c3d file and store main information in mat files
%
% USAGE: Input files folder path MUST included a folder named 'InputData'
%       Output folders may be managed in mkOutputPath.m
%       Cancel the created sessionData folder if you modify the code before
%       rerunning it: data already saved are not overwritten!

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

function []=C3D2MAT()

addSharedPath()
runTerminalNote()

%% Selection of input data 
pathName = uigetdir('Select your input data folder');
c3dFiles = dir ([pathName filesep '*.c3d']);

h = waitbar(0,'Elaborating data...Please wait!');

for k=1:length(c3dFiles)
    
    %correction of the name --> after uniformation it should not be necessary
    trialsName{k} = regexprep(regexprep((regexprep(c3dFiles(k).name, ' ' , '')), '-',''), '.c3d', '');
    
    %Folders and paths creation
    c3dFilePathAndName = fullfile (pathName, c3dFiles(k).name);
        
    trialMatFolder=mkOutputPath(pathName,trialsName{k});
    
    sessionFolder=regexprep(trialMatFolder, [trialsName{k} filesep], '');
    
    %Data Reading    
    [Markers, AnalogData, FPdata, Events, ForcePlatformInfo, Rates] = getInfoFromC3D(c3dFilePathAndName);
    
    %Consistency check and Storing: 
    %only if the trial is not a static because it may have different data
    %(in that case their are saved anyway in the static trial folder)
    
    if isempty(strfind(upper(trialsName{k}),'STATIC'))
        %Common Session Info (excluding static trials)
        if isempty(Markers)
            dMLabels=[];
        else
            dMLabels=Markers.Labels;
        end
        if isempty(AnalogData)
            AnalogDataLabels=[];
        else
            AnalogDataLabels=AnalogData.Labels;
        end
        
        checkAndSaveSessionInfo(ForcePlatformInfo, Rates, dMLabels, AnalogDataLabels, sessionFolder);
    end
    %Data for each trials
    saveMat(Markers,AnalogData,FPdata, Events, trialMatFolder)

    waitbar(k/length(c3dFiles));    
end
close(h)

%Saving trialsName list of read c3d file at the end
save([sessionFolder 'trialsName.mat'],'trialsName')

%save_to_base(1)
% save_to_base() copies all variables in the calling function to the base
% workspace. This makes it possible to examine this function internal
% variables from the Matlab command prompt after the calling function
% terminates. Uncomment the following command if you want to activate it


     