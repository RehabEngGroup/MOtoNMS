%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Read a c3d file and store main information in mat files
%
%USAGE: Input files folder path MUST included a folder named 'InputData'
%       Output folders may be managed in mkOutputPath.m
%       Cancel the created sessionData folder if you modify the code before
%       rerunning it: data already saved are not overwritten!
%
%Before running the file is possible to choose if we want the data in a
%struct or in matrix according to following computations: to do this see
%getInfoFromC3D
%
%Implemented by Alice Mantoan, July 2012, <alice.mantoan@dei.unipd.it>
%Last version April 2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Selection of input data 
pathName = uigetdir(' ','Select your input data folder');
c3dFiles = dir ([pathName '\*.c3d']);

h = waitbar(0,'Elaborating data...Please wait!');

for k=1:length(c3dFiles)
    
    %correction of the name --> after uniformation it should not be necessary
    trialsName{k} = regexprep(regexprep((regexprep(c3dFiles(k).name, ' ' , '')), '-',''), '.c3d', '');
    
    %Folders and paths creation
    c3dFilePathAndName = fullfile (pathName, c3dFiles(k).name);
        
    trialMatFolder=mkOutputPath(pathName,trialsName{k});
    
    sessionFolder=regexprep(trialMatFolder, [trialsName{k} '\'], '');
    
    %Data Reading    
    [Markers, AnalogData, FPdata, Events, ForcePlatformInfo, Rates] = getInfoFromC3D(c3dFilePathAndName);
    
    %Consistency check and Storing: 
    %only if the trial is not a static because it may have different data
    %(in that case their are saved anyway in the static trial folder)
    
    if isempty(strfind(upper(trialsName{k}),'STATIC'))
        %Common Session Info (excluding static trials)
        if isempty(Markers)
            dMLabels=[];
        else
            dMLabels=Markers.Labels;
        end
        if isempty(AnalogData)
            AnalogDataLabels=[];
        else
            AnalogDataLabels=AnalogData.Labels;
        end
        
        checkAndSaveSessionInfo(ForcePlatformInfo, Rates, dMLabels, AnalogDataLabels, sessionFolder);
    end
    %Data for each trials
    saveMat(Markers,AnalogData,FPdata, Events, trialMatFolder)

    waitbar(k/length(c3dFiles));    
end
close(h)

%Saving trialsName list of read c3d file at the end
save([sessionFolder 'trialsName.mat'],'trialsName')

     