%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         MATLAB DATA PROCESSING TOOLBOX for Applications in OPENSIM      %
%                           STATIC Elaboration                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Starting program for Static Elaboration: run the interface for static.xml
% file creation
%
%
% Implemented by Alice Mantoan, March 2013, <alice.mantoan@dei.unipd.it>

%% ----------------------------STARTING------------------------------------
clear all
%runStaticSplashScreen
%--------------------------------------------------------------------------

newElaboration=1;
e=1;

while newElaboration==1 
    %%
    foldersPaths=foldersPathsDefinition();
    
    %Acquisition Info: load Acquisition.xml
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