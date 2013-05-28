%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    MATLAB DATA PROCESSING TOOLBOX                       %
%                     for Applications in OPENSIM                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mainAcquisitionInterface.m
% Main function for the generation of acquisition.xml file, which is needed 
% to describe a data set. It runs AcquisitionInterface.m
%
% Implemented by Alice Mantoan, Febrary 2013, <alice.mantoan@dei.unipd.it>

clear all
%Comment the following line to disable the splashscreen 
%runAcquisitionSplashScreen()

%Options
choice=questdlg('What would you like to do?', ...
    'Acquisition Interface',...
    'New', 'Load', ' ');

switch choice
    case 'New'
        
        AcquisitionInterface();
        
    case 'Load'
        
        [oldAcquisitionFileName,oldAcquisitionFilePath] = uigetfile([ '/*.xml'],'Select acquisition.xml file to load');
        oldAcquisition=xml_read([oldAcquisitionFilePath '\' oldAcquisitionFileName]);
        AcquisitionInterface(oldAcquisition);
end

h = msgbox('acquisition.xml file has been saved','Done!');
uiwait(h)
