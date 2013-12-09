%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               MOtoNMS                                   %
%                MATLAB MOTION DATA ELABORATION TOOLBOX                   %
%                 FOR NEUROMUSCULOSKELETAL APPLICATIONS                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Starting program for Static Elaboration: run the interface for static.xml
% file creation

% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2013 Alice Mantoan, Monica Reggiani
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


%% ----------------------------STARTING------------------------------------
clear all
%Comment the following line to disable the splashscreen 
%runSplashScreen
runTerminalNote()
%--------------------------------------------------------------------------

newElaboration=1;
e=1;

while newElaboration==1 
    %%
    foldersPaths=foldersPathsDefinition();
    
    %Acquisition Info: load acquisition.xml
    acquisitionInfo=xml_read([foldersPaths.inputFile '\acquisition.xml']);
    
    elaborationPaths{e}=foldersPaths.elaboration;
  
    %Choosing what to do
    choice=staticOptions();
    
    switch choice
        case 'New Static Elaboration'
            
            staticConfigurationFileGeneration(foldersPaths,acquisitionInfo);
            
        case 'Load and Modify static.xml'
            
            [oldStaticSettingsName,oldStaticSettingsPath] = uigetfile([foldersPaths.staticElaborations '/*.xml'],'Select static.xml file');
            oldStaticSettings=xml_read([oldStaticSettingsPath '\' oldStaticSettingsName]);
            staticConfigurationFileGeneration(foldersPaths,acquisitionInfo,oldStaticSettings);
    end
        
    h = msgbox('static.xml file has been saved','Done!');
    uiwait(h)
    
    choice2 = questdlg('Would you like also to run the static elaboration?', ...
        'Static Elaboration Interface', ...
        'Quit','New','Run Static Elaborations','Run Static Elaborations');
    
    if strcmp(choice2,'Run Static Elaborations')
        for ne=1:e
        runStaticElaboration(elaborationPaths{ne});
        end
    end
    
    if strcmp(choice2,'New')==0
        newElaboration=0;
    end
    e=e+1;
    
end