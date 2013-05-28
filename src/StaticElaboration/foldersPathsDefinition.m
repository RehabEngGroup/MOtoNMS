function [foldersPaths]=foldersPathsDefinition (inputPath,trialName,configFilePath)

if nargin>0
    %when the path is available is not necessary to ask the user
    inputFilePath=inputPath;
       
else

    [fileName,inputFilePath] = uigetfile([ '/*.c3d'],'Select .c3d input file for static elaboration');
    
    trialName = regexprep(regexprep((regexprep(fileName, ' ' , '')), '-',''), '.c3d', '');
    
end

%Output folder: Elaborated Data
ElaboratedDataPath=regexprep(inputFilePath, 'InputData', 'ElaboratedData');

if exist(ElaboratedDataPath,'dir') ~= 7
    mkdir (ElaboratedDataPath);
end

%Session Data folder
sessionDataFolder=[ElaboratedDataPath 'sessionData\'];

matDataPath=[sessionDataFolder trialName ];


staticElaborationsPath=[ElaboratedDataPath 'staticElaborations\'];

if exist(staticElaborationsPath,'dir') ~= 7
    mkdir (staticElaborationsPath);
end

%Elaboration folder
if nargin>2
    
    elaborationPath=configFilePath;
else
        
    %ask for an identificator for this specific elaboration
    IDstaticElaboration = cell2mat(inputdlg('Insert New Elaboration Identificator'));
    
    elaborationPath=[staticElaborationsPath trialName '\' IDstaticElaboration '\'];
    
    if exist(elaborationPath,'dir') ~= 7
        mkdir (elaborationPath);
    end
end



foldersPaths.inputFile=inputFilePath;
foldersPaths.elaboratedData=ElaboratedDataPath;
foldersPaths.matData=matDataPath;
foldersPaths.staticElaborations=staticElaborationsPath;
foldersPaths.elaboration=elaborationPath;


% % 
% % matDataPath = uigetdir(' ','Select your STATIC .mat data folder');
% % i=strfind(matDataPath,'\sessionData');
% % 
% % Output folder: Elaborated Data
% % ElaboratedDataPath=matDataPath(1:i);
% % 
% % acquisitionPath=regexprep(ElaboratedDataPath, 'ElaboratedData', 'InputData');
