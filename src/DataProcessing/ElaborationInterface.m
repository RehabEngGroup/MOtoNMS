%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               MOtoNMS                                   %
%                MATLAB MOTION DATA ELABORATION TOOLBOX                   %
%                 FOR NEUROMUSCULOSKELETAL APPLICATIONS                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ElaborationInterface.m

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

function []=ElaborationInterface()

clear all
addSharedPath()

%Comment the following line to disable the splashscreen 
%runSplashScreen
runTerminalNote()

%% 
newElaboration=1;
e=1;

while newElaboration==1 
       
    %Choosing what to do
    choice=elaborationInterfaceOptions();
    
    if strcmp(choice,'Run elaboration')==0
        %Following information are not required if the choice is equal to 
        %just run an already defined elaboration
        
        %Folders Definitions
        foldersPath=foldersDefinition ();
        
        elaborationPaths{e}=foldersPath.elaboration;
        %Trials Name
        c3dFiles = dir ([foldersPath.inputData filesep '*.c3d']);
        
        %Name correction/check
        for k=1:length(c3dFiles)
            trialsName{k} = regexprep(regexprep((regexprep(c3dFiles(k).name, ' ' , '')), '-',''), '.c3d', '');
        end

        %Acquisition Info: load acquisition.xml
        acquisitionInfo=xml_read([foldersPath.inputData filesep 'acquisition.xml']);
    end
    
    switch choice
        case 'New elaboration'
            
            elaborationFileCreation(foldersPath,trialsName,acquisitionInfo);
            elaborationFile=1;
            
        case 'Load and Modify elaboration.xml'
            
            [oldElaborationFileName,oldElaborationFilePath] = uigetfile([foldersPath.outputData filesep '*.xml'],'Select elaboration.xml file',pwd);
            oldElaboration=xml_read([oldElaborationFilePath filesep oldElaborationFileName]);
            elaborationFileCreation(foldersPath,trialsName,acquisitionInfo,oldElaboration);
            elaborationFile=1;       
            
        case 'Run elaboration'
            
            [elaborationFileName,elaborationFilePath] = uigetfile([ filesep '*.xml'],'Select elaboration.xml file', pwd);
            runDataProcessing(elaborationFilePath);
            elaborationFile=0;
    end
    
    if elaborationFile==1
        
        h = msgbox('elaboration.xml file has been saved','Done!');
        uiwait(h)
        
        choice2 = questdlg('Would you like also to run the elaboration?', ...
            'Elaboration Interface', ...
            'Quit','New','Run elaborations','Run elaborations');
        
        if strcmp(choice2,'Run elaborations')
            for ne=1:e
                runDataProcessing(elaborationPaths{ne});
            end
        end
        
        if strcmp(choice2,'New')==0
            newElaboration=0;
        end
        e=e+1;
    else
        return
    end
end
