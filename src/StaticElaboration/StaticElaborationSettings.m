function [foldersPath,parameters]= StaticElaborationSettings(ConfigFilePath)

try
    staticSettings=xml_read([ConfigFilePath '\static.xml']);
    disp(['Running ' ConfigFilePath '\static.xml'])
catch
    disp('static.xml file not fuond in the specified path')
end

%Acquisition.xml file path reconstruction
i=strfind(ConfigFilePath,'ElaboratedData');

acquisitionPath=[ConfigFilePath(1:(i-1)) staticSettings.FolderName(3:end)];

%Acquisition Info: load Acquisition.xml
acquisitionInfo=xml_read([acquisitionPath '\acquisition.xml']);

trialName=staticSettings.TrialName;

%Folders Definition
foldersPath=foldersPathsDefinition(acquisitionPath,trialName,ConfigFilePath);

%Parameters.mat file Generation
parameters=staticParametersGeneration(staticSettings,acquisitionInfo,foldersPath);