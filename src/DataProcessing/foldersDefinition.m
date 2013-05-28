function [foldersPath]=foldersDefinition (initialPath,ElaborationFilePath)

if nargin>0
    %when the path is available is not necessary to ask the user
    inputDataPath=initialPath;
       
else
    %Input data folder manual selection for the user interface
    inputDataPath = uigetdir(' ','Select your input data folder');
    
end

%Output folder: Elaborated Data
outputsFolderPath=regexprep(inputDataPath, 'InputData', 'ElaboratedData');

if exist(outputsFolderPath,'dir') ~= 7
    mkdir (outputsFolderPath);
end

%Session Data folder
sessionDataFolder=[outputsFolderPath '\sessionData\'];


%Elaboration folder
if nargin>1
    
    elaborationFolderPath=ElaborationFilePath;
else
        
    %ask for an identificator for this specific elaboration
    IDelaboration = cell2mat(inputdlg('Insert New Elaboration Identificator'));
    
    %elaborationFolderPath=[outputsFolderPath '\elaboration_' IDelaboration '\'];
    elaborationFolderPath=[outputsFolderPath '\' IDelaboration '\'];
    
    if exist(elaborationFolderPath,'dir') ~= 7
        mkdir (elaborationFolderPath);
    end
end

%struct with all folder paths

foldersPath.inputData=inputDataPath;
foldersPath.outputData=outputsFolderPath;
foldersPath.sessionData=sessionDataFolder;
foldersPath.elaboration=elaborationFolderPath;
