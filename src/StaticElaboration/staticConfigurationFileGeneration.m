%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         MATLAB DATA PROCESSING TOOLBOX for Applications in OPENSIM      %
%                           STATIC Elaboration                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create static.xml file 
% 
% Implemented by Alice Mantoan, March 2013, <alice.mantoan@dei.unipd.it>

function []=staticConfigurationFileGeneration(foldersPaths,acquisitionInfo,oldConfigSettings,varargin)

if nargin>2 
    oldParameters=staticParametersGeneration(oldConfigSettings);
end


%% ------------------------FCUTs Definition--------------------------------
fcMarkersChoice = questdlg('Do you want to filter Markers trajectories?', ...
    'Markers Filtering', ...
    'Yes','No','Yes');

if strcmp(fcMarkersChoice,'Yes')==1
    
    %Definition of Default Values
    if (nargin>2 && isfield(oldParameters,'Fcut'))
        
        def_fcut=oldParameters.Fcut;      
    else       
        switch acquisitionInfo.Laboratory.Name
            case 'UNIPD'
                def_fcut={'6'};
                
            case 'UWA'
                def_fcut={'8'};
            otherwise
                def_fcut{1}=' ';               
        end
    end

    dlg_title='Static Trial';
    prompt ='Choose Cut Off Frequency for Filtering';
    num_lines = 1;
    options.Resize='on';
    options.WindowStyle='modal';
    answer = inputdlg(prompt,dlg_title,num_lines,def_fcut,options);
    
    fcut=answer'; 
end


%% ------------------File xml structure definition-------------------------

%FolderName
%necessary to have "InputData" in the path
ind=strfind(foldersPaths.inputFile, 'InputData');
staticSettings.FolderName=['.\' foldersPaths.inputFile(ind:end)];

%TrialName

i=strfind(foldersPaths.matData,'\sessionData');
trialName=foldersPaths.matData(i+13:end);
staticSettings.TrialName=trialName;
 
%Fcut
if exist('fcut','var') 
    staticSettings.Fcut=fcut;
end


%% --------------------Joint Center Computation Methods--------------------

originalPath=pwd;
cd('..')
cd('..')
JCcomputationFolderPath=[pwd '\ConfigurationFiles\StaticElaboration\JCcomputation\']; 
dirList=ls(JCcomputationFolderPath);
cd (originalPath)
                             
for j=3:size(dirList,1)                         %dirList(1,:) always = '.' 
                                                %dirList(2,:) always = '..'
    jointList{j-2}=regexprep(dirList(j,:), ' ' , '');
end

if nargin>2
    
    for i=1:length(oldParameters.JCcomputation.Joint)
        oldJointList{i}=oldParameters.JCcomputation.Joint(i).Name;
    end
    oldJointIndex=findIndexes(jointList,oldJointList);
    
    for i=1:length(oldParameters.JCcomputation.Joint)
        
        oldJointMethod{i}=oldParameters.JCcomputation.Joint(i).Name;
    end
else
    oldJointIndex=[];
    oldJointMethod=[];
end

%Joint Selection
[jointIndex,v] = listdlg('PromptString','Select Joints for Center Computation:',...
    'SelectionMode','multiple',...
    'ListString',jointList,...
    'ListSize',[250 200],...
    'InitialValue', oldJointIndex);  

jointCenters=jointList(jointIndex);

if nargin>2
    oldMethodIndex=findIndexes(oldJointList,jointCenters);
end

for k=1:size(jointCenters,2)

    joint=jointCenters{k};
    
    JCmethodFilePath=[JCcomputationFolderPath joint];
    JCfiles = dir ([JCmethodFilePath '\*.xml']);

    if length(JCfiles)>1    %ask for the file only if more than one file 
                            %in the folder
        if nargin>2

            oldFileName=[oldParameters.JCcomputation.Joint(oldMethodIndex(k)).Method ];
            [JCmethodFileName] = uigetfile([JCmethodFilePath '\*.xml'],'Select .xml file corresponding to the JC Computation Method',[JCmethodFilePath '\' oldFileName '.xml']);
        else
            cd(JCmethodFilePath)
            [JCmethodFileName] = uigetfile([JCmethodFilePath '\*.xml'],'Select .xml file corresponding to the JC Computation Method');
            cd (originalPath)
         end
    else
        JCmethodFileName=JCfiles(1).name;
    end
    
    Pref.ReadAttr=false;
    JCmethod=xml_read([JCmethodFilePath '\' JCmethodFileName],Pref);
    disp(['File ' JCmethodFilePath '\' JCmethodFileName 'has been loaded'])
    
    %Creating Joint Structure
    
    Joint(k).Name=joint;
    %Joint(k).Method=JCmethodFileName(1:end-4); 
    %file name should be the same of the corresponding method
    Joint(k).Method=JCmethod.Name;       
    
    %Selection acccording to the protocol

    if isfield(JCmethod,'MarkersDefinition')
        for i=1:length(JCmethod.MarkersDefinition.Protocol)
            
            if (strcmp(JCmethod.MarkersDefinition.Protocol(i).Name,acquisitionInfo.MarkersProtocol.Name))
                Joint(k).Input.MarkerNames=JCmethod.MarkersDefinition.Protocol(i).MarkerNames;
            end
        end
        
        if (isfield(Joint(k),'Input')==0)
            error(['Check ' JCmethodFileName ': Markers Protocol missing!'])
        end       
    end
end

%Updating staticSettings struct
staticSettings=setfield(staticSettings,'JCcomputation',[]);
staticSettings.JCcomputation.Joint=Joint;


%% ------------Markers Selection to be written in the trc file-------------
%needed for trcMarkersIndexes computation in the case nargin>3
MarkersSet=textscan(acquisitionInfo.MarkersProtocol.MarkersSetStaticTrials, '%s','delimiter', ' ');
MarkersSet=MarkersSet{1};

%Definition of Lists Initial Values
if nargin>2
      
    %find indexes for the listdlg command    
    trcMarkersIndexes=findIndexes(MarkersSet,oldParameters.trcMarkersList);
    InitialValue.MarkersList=trcMarkersIndexes;    
else
    InitialValue.MarkersList=[];
end

[markersIndex,v] = listdlg('PromptString','Select markers to write in .trc file:',...
                'SelectionMode','multiple',...
                'ListString',MarkersSet,...
                'InitialValue', InitialValue.MarkersList);
            
MarkersList=MarkersSet(markersIndex);

Markers=[];
for i=1:length(MarkersList)
    Markers=[Markers MarkersList{i} ' '];
end

%Adding to staticSettings struct
staticSettings.trcMarkers=Markers;


%---------------------Static.xml writting-----------------------------
Pref.StructItem=false;
Pref.CellItem=false;

xml_write([foldersPaths.elaboration 'static.xml'],staticSettings,'static',Pref);

save_to_base(1)


