%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   MATLAB DATA PREPROCESSING TOOLBOX                     %
%                     for Applications in OPENSIM                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ElaborationInterface.m
%
%
% Implemented by Alice Mantoan, August 2012, <alice.mantoan@dei.unipd.it>
% Last version April 2013

%% ----------------------------STARTING------------------------------------
clear all
% runSplashScreen
%--------------------------------------------------------------------------

newElaboration=1;
e=1;

while newElaboration==1 
    %%
    %Folders Definitions
    foldersPath=foldersDefinition ();
    elaborationPaths{e}=foldersPath.elaboration;
    %Trials Name
    c3dFiles = dir ([foldersPath.inputData '\*.c3d']);
    
    %Name correction/check: after standadization it will not be necessary
    for k=1:length(c3dFiles)
        trialsName{k} = regexprep(regexprep((regexprep(c3dFiles(k).name, ' ' , '')), '-',''), '.c3d', '');
    end
    
    %Acquisition Info: load Acquisition.xml
    acquisitionInfo=xml_read([foldersPath.inputData '\acquisition.xml']);
    
    %Choosing what to do
    choice=elaborationIterfaceOptions();
    
    switch choice
        case 'New elaboration'
            
            elaborationFileCreation(foldersPath,trialsName,acquisitionInfo);
            elaborationFile=1;
            
        case 'Load and Modify elaboration.xml'
            
            [oldElaborationFileName,oldElaborationFilePath] = uigetfile([foldersPath.outputData '/*.xml'],'Select elaboration.xml file');
            oldElaboration=xml_read([oldElaborationFilePath '\' oldElaborationFileName]);
            elaborationFileCreation(foldersPath,trialsName,acquisitionInfo,oldElaboration);
            elaborationFile=1;       
            
        case 'Run elaboration'
            
            [elaborationFileName,elaborationFilePath] = uigetfile([foldersPath.outputData '/*.xml'],'Select elaboration.xml file');
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
