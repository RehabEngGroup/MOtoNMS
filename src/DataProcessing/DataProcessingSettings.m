function [foldersPath,parameters]= DataProcessingSettings(ElaborationFilePath)

try
    elaboration=xml_read([ElaborationFilePath '\elaboration.xml']);
    disp(['Running ' ElaborationFilePath '\elaboration.xml'])
catch
    disp('elaboration.xml file not fuond in the specified path')
end

%Acquisition.xml file path reconstruction
i=strfind(ElaborationFilePath,'ElaboratedData');

acquisitionPath=[ElaborationFilePath(1:(i-1)) elaboration.FolderName(3:end)];

%Acquisition Info: load Acquisition.xml
acquisitionInfo=xml_read([acquisitionPath '\acquisition.xml']);

%Folders Definition
foldersPath=foldersDefinition(acquisitionPath,ElaborationFilePath);

%Parameters.mat file Generation
parameters=parametersGeneration(elaboration,acquisitionInfo,foldersPath);