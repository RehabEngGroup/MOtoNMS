%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               MOtoNMS                                   %
%                MATLAB MOTION DATA ELABORATION TOOLBOX                   %
%                 FOR NEUROMUSCULOSKELETAL APPLICATIONS                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mainAcquisitionInterface.m
% Main function for the generation of acquisition.xml file, which is needed 
% to describe a data set. It runs AcquisitionInterface.m

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
clear all
%Adding shared folder path
originalPath=pwd;
cd('../shared')
addpath(pwd)
cd (originalPath)

%Comment the following line to disable the splashscreen 
runSplashScreen()
runTerminalNote()

%Options
choice=questdlg('What would you like to do?', ...
    'Acquisition Interface',...
    'New', 'Load', ' ');

switch choice
    case 'New'
        
        AcquisitionInterface();
        
    case 'Load'
        
        [oldAcquisitionFileName,oldAcquisitionFilePath] = uigetfile([ filesep '*.xml'],'Select acquisition.xml file to load', pwd);
        oldAcquisition=xml_read([oldAcquisitionFilePath filesep oldAcquisitionFileName]);
        AcquisitionInterface(oldAcquisition);
end

h = msgbox('acquisition.xml file has been saved','Done!');
uiwait(h)
