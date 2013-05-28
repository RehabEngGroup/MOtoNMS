function trialMatFolder= mkOutputPath(pathName,trialName)

warning off
%Change in the pathName 'InputData' with 'ElaboratedData'
sessionDataFolderPath=regexprep(pathName, 'InputData', 'ElaboratedData');

%create ElaboratedData folder if it does not exit
if exist(sessionDataFolderPath,'dir') ~= 7
    mkdir (sessionDataFolderPath);
end

%create sessionData folder if it does not exit
if exist([sessionDataFolderPath 'sessionData'],'dir') ~= 7
    mkdir ([sessionDataFolderPath '\sessionData']);
end

%create trial folder if it does not exit
if exist([sessionDataFolderPath 'sessionData\' trialName],'dir') ~= 7
    mkdir ([sessionDataFolderPath '\sessionData\' trialName]);
end

trialMatFolder=[sessionDataFolderPath '\sessionData\' trialName '\'];
%folder where mat files will be stored