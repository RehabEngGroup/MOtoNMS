 function [] = elaborationFileCreation(foldersPath,trialsName,acquisitionInfo,oldElaboration,varargin)
% Function to generate elaboration.xml file

% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2012-2014 Alice Mantoan, Monica Reggiani
%
% MOtoNMS is free software: you can redistribute it and/or modify it under 
% the terms of the GNU General Public License as published by the Free 
% Software Foundation, either version 3 of the License, or (at your option)
% any later version.
%
% Matlab MOtion data elaboration TOolbox for NeuroMusculoSkeletal applications
% is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
% without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
% PARTICULAR PURPOSE.  See the GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along 
% with MOtoNMS.  If not, see <http://www.gnu.org/licenses/>.
%
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>


%% -------------------------Initial Settings-------------------------------
%create a cell from char values read from acquisition.xml for the selection
%of Markers to be written in the trc file
%needed for trcMarkersIndexes computation within case nargin>3
MarkersSet=textscan(acquisitionInfo.MarkersProtocol.MarkersSetDynamicTrials, '%s','delimiter', ' ');
MarkersSet=MarkersSet{1};

%Definition of Lists Initial Values
if nargin>3
    
    oldParameters=parametersGeneration(oldElaboration);
    %find indexes for the listdlg command
    trialsIndexes=findIndexes(trialsName,oldParameters.trialsList);    
    trcMarkersIndexes=findIndexes(MarkersSet,oldParameters.trcMarkersList);
    
    InitialValue.Trials=trialsIndexes;
    InitialValue.WindowsSelection.Method=oldParameters.WindowsSelection.Method; 
    InitialValue.MarkersList=trcMarkersIndexes;
    
    if isfield(oldParameters,'OutputFileFormats')
        if isfield(oldParameters.OutputFileFormats,'MarkerTrajectories')
            InitialValue.OutputFileFormats.MarkerTrajectories=oldParameters.OutputFileFormats.MarkerTrajectories;
        else
            InitialValue.OutputFileFormats.MarkerTrajectories='.trc';
        end
        
        if isfield(oldParameters.OutputFileFormats,'GRF')
            InitialValue.OutputFileFormats.GRF=oldParameters.OutputFileFormats.GRF;
        else
            InitialValue.OutputFileFormats.GRF='.mot';
        end
        
        if isfield(oldParameters.OutputFileFormats,'EMG')
            InitialValue.OutputFileFormats.EMG=oldParameters.OutputFileFormats.EMG;
        else
            InitialValue.OutputFileFormats.EMG='.mot';
        end       
    else
        %Default file formats
        InitialValue.OutputFileFormats.MarkerTrajectories='.trc';
        InitialValue.OutputFileFormats.GRF='.mot';
        InitialValue.OutputFileFormats.EMG='.mot';
    end
    
else
    InitialValue.Trials=[];
    InitialValue.MarkersList=[];
    InitialValue.WindowsSelection.Method='.';
    %Output file formats: default file formats
    InitialValue.OutputFileFormats.MarkerTrajectories='.trc';
    InitialValue.OutputFileFormats.GRF='.mot';
    InitialValue.OutputFileFormats.EMG='.mot'; 
end

%% ---------Looking for EMGs and EMGs depending initial settings-----------
if isfield(acquisitionInfo,'EMGs') %there are EMGs --> they will be processed
  
    %Definition of EMGs Lists Initial Values
    if nargin>3
            
        emgMaxTrialsIndexes=findIndexes(trialsName,oldParameters.MaxEmgTrialsList);
        InitialValue.emgMaxTrials=emgMaxTrialsIndexes;
    else
        InitialValue.emgMaxTrials=[];
    end
    
    %Leg Definition (required for Analysis Window Definition Method)
    InstrumentedLeg=acquisitionInfo.EMGs.Protocol.InstrumentedLeg;
    
    %EMG found
    EMGfound=1;
    
else
    EMGfound=0;
    InstrumentedLeg='None';

end

%--------------------------------------------------------------------------
%% --------------------------Trials Selection-------------------------------
 
[trialsIndex,v] = listdlg('PromptString','Select trials to elaborate:',...
                'SelectionMode','multiple',...
                'ListString',trialsName,...
                'InitialValue',InitialValue.Trials);
            
trialsList=trialsName(trialsIndex);        

%% ------------ MaxGapSize for Markers Interpolation Definition -----------
%Fix by default: the value can be changed manuallly in the elaboration.xml
if (nargin>3 && isfield(oldParameters,'MarkersInterpolation'))
    MaxGapSize_default=oldParameters.interpolationMaxGapSize;
else    
    referenceValue=15; %fix considering a VideoFrameRate of 60 Hz
    MaxGapSize_default=referenceValue/60*acquisitionInfo.VideoFrameRate;
end
        
%% ------------------------FCUTs Definition--------------------------------

trialsTypeList=trialsTypeIdentification(trialsList); 
    
%--------------------Definition of Default Values-------------------------- 
num_lines = 1; 
options.Resize='on';
options.WindowStyle='modal';

if (nargin>3 && isfield(oldParameters,'fcut'))
    
    oldTrialsTypeList=trialsTypeIdentification(oldParameters.trialsList);   
    
    if isfield(oldParameters.fcut,'m')
        def_m=getDefValuesForFiltering(trialsTypeList,oldTrialsTypeList, oldParameters.fcut.m);
    end
    
    if isfield(oldParameters.fcut,'f')
        def_f=getDefValuesForFiltering(trialsTypeList,oldTrialsTypeList, oldParameters.fcut.f);
    end
    
    if isfield(oldParameters.fcut,'cop')
        def_cop=getDefValuesForFiltering(trialsTypeList, oldTrialsTypeList, oldParameters.fcut.cop);
    end
    
else
    lab=acquisitionInfo.Laboratory.Name;
    
    for i=1:length(trialsTypeList)
        
        type=upper(getTrialType(trialsTypeList{i}));
        
        switch type
            
            case 'WALKING'
                
                switch lab
                    case 'UNIPD'
                        def_m{i}='7';
                        def_f{i}='7';
                        def_cop{i}='7'; %corresponding to wn=0.0146 and sampling rate=1000
                        
                    case 'UWA'
                        def_m{i}='8';
                        def_f{i}='8';
                        %def_cop{i}='0'; not necessary cop filtering
                    otherwise
                        def_m{i}='8';
                        def_f{i}='8';
                end
                
            case 'RUNNING'
                def_m{i}='12';
                def_f{i}='12';
                
            case 'SIDESTEP'
                def_m{i}='10';
                def_f{i}='10';
                
            case 'FASTWALKING'
                def_m{i}='10';
                def_f{i}='10';
                
            case 'CROSSOVERS'
                def_m{i}='10';
                def_f{i}='10';
                
            otherwise
                def_m{i}=' ';
                def_f{i}=' ';
                def_cop{i}=' ';
        end
    end
end

%--------------------------MARKERS Filtering-------------------------------
fcMarkersChoice = questdlg('Do you want to filter Markers trajectories?', ...
	'Markers Filtering', ...
	'Yes','No','Yes');

if strcmp(fcMarkersChoice,'Yes')==1
    %Ask for Markers Filter cut off frequency
    for i=1:length(trialsTypeList)
        dlg_title='Choose Cut Off Frequency for Markers Filtering'; 
        prompt{i} = trialsTypeList{i};
    end 

    answer = inputdlg(prompt,dlg_title,num_lines,def_m,options);
    
    m_fcut_xType=answer';   
    m_fcut=fromTypeToSingle(trialsList,trialsTypeList,m_fcut_xType);
end

%-------------------------FORCES Filtering---------------------------------

fcForcesChoice = questdlg('Do you want to filter Forces?', ...
	'Forces Filtering', ...
	'Yes','No','Yes');

if strcmp(fcForcesChoice,'Yes')==1
    %Ask for Forces Filter cut off frequency
    for i=1:length(trialsTypeList)
        dlg_title='Choose Cut Off Frequency for Forces Filtering';
        prompt{i} = trialsTypeList{i};
        %def{i} = '3'; %default value corresponding to Bertec
    end
    
    answer = inputdlg(prompt,dlg_title,num_lines,def_f,options);
    
    f_fcut_xType=answer';   
    f_fcut=fromTypeToSingle(trialsList,trialsTypeList,f_fcut_xType);
end

%-------------------------COP Filtering------------------------------------
%Ask for COP Filter cut off frequency if Force Plates are of type 1
for i=1: size(acquisitionInfo.Laboratory.ForcePlatformsList.ForcePlatform,2)
    FPsType(i)=acquisitionInfo.Laboratory.ForcePlatformsList.ForcePlatform(i).Type;
end

if  FPsType==1  %check both FPs
    
    fcCopChoice = questdlg('Do you want to filter COP?', ...
	'COP Filtering', ...
	'Yes','No','Yes');

    if strcmp(fcCopChoice,'Yes')==1
        
        dlg_title='Choose Cut Off Frequency for COP Filtering';
        
        for i=1:length(trialsTypeList)          
            prompt{i} = trialsTypeList{i};        
        end     

        answer = inputdlg(prompt,dlg_title,num_lines,def_cop,options);
        
        cop_fcut_xType=answer';
        cop_fcut=fromTypeToSingle(trialsList,trialsTypeList,cop_fcut_xType);
    end

end


%% ------------------Analysis Window Definition Method---------------------

%List of Available Methods
AWmethodOptions = {'.','ComputeStancePhase','StanceOnFPfromC3D','WindowFromC3D','Manual'};

oldMethodIndex=find(strcmp(InitialValue.WindowsSelection.Method,AWmethodOptions));

%Method Selection
[methodIndex,v] = listdlg('PromptString','Select Method for Analysis Window Computation:',...
    'SelectionMode','single',...
    'ListString',AWmethodOptions,...
    'ListSize',[250 200],...
    'InitialValue',oldMethodIndex);  

method=AWmethodOptions{methodIndex};

%Windows Selection Procedure Struct Definition

WindowSelectionProcedure=struct;

switch method
    
    case 'ComputeStancePhase'
        
        leg=setAnalysisLeg(InstrumentedLeg);

        prompt='Insert Frame Offset before Foot Strike and after Foot Off';
        num_lines = 1;
        options.Resize='on';
        options.WindowStyle='modal';
        if (nargin > 3 && strcmp(InitialValue.WindowsSelection.Method,'ComputeStancePhase')==1) %if  previous Elaboration.xml has been load
            defoffset{1}=num2str(oldParameters.WindowsSelection.Offset);
        else
            defoffset={'0'};
        end
            
        answer = inputdlg(prompt,'Analysis Window Offset from Stance',num_lines,defoffset,options);
        
        eval(['WindowSelectionProcedure.' method '.Leg=leg;'])
        eval(['WindowSelectionProcedure.' method '.Offset=answer{1};'])  

        

    case 'StanceOnFPfromC3D'
        
        clear prompt        
        
        leg=setAnalysisLeg(InstrumentedLeg);
        
        dlg_title='StanceOnFPfromC3D Method';
        prompt{1} = 'Insert Label for Heel Strike';
        prompt{2}= 'Insert Label for Toe Off';
        
        if (nargin > 3 && strcmp(InitialValue.WindowsSelection.Method,'StanceOnFPfromC3D')==1) %if  previous Elaboration.xml has been load
            defanswer{1}=oldParameters.WindowsSelection.Labels.HS;
            defanswer{2}=oldParameters.WindowsSelection.Labels.FO;
            defoffset{1}=num2str(oldParameters.WindowsSelection.Offset);
        else
            defanswer={'Foot Strike';'Foot Off'}; %default name with mokka    
            defoffset={'0'};
        end
           
        num_lines =1;
    
        answer = inputdlg(prompt,dlg_title,num_lines,defanswer, options);
        LabelForHeelStrike=answer{1};
        LabelForToeOff=answer{2};
        
        prompt='Insert Frame Offset before Foot Strike and after Foot Off';
        num_lines = 1;
        options.Resize='on';
        options.WindowStyle='modal';
        
        answer = inputdlg(prompt,'Analysis Window Offset from Stance',num_lines,defoffset,options);
       
        eval(['WindowSelectionProcedure.' method '.Leg=leg;'])
        eval(['WindowSelectionProcedure.' method '.LabelForHeelStrike=LabelForHeelStrike;'])
        eval(['WindowSelectionProcedure.' method '.LabelForToeOff=LabelForToeOff;'])     
        
        eval(['WindowSelectionProcedure.' method '.Offset=answer{1};'])
        
    case 'WindowFromC3D'
        
        clear prompt
        
        dlg_title='WindowFromC3D Method';
        prompt{1} = 'Insert Full Label for Start Event (Context - Right/Left/General - + Label)';
        prompt{2}= 'Insert Label for Stop Event (Context - Right/Left/General - + Label)';
        
        num_lines =1;
    
        if (nargin > 3 && strcmp(InitialValue.WindowsSelection.Method,'WindowFromC3D')==1) %if  previous Elaboration.xml has been load
            defanswer{1}=oldParameters.WindowsSelection.Labels.Start;
            defanswer{2}=oldParameters.WindowsSelection.Labels.Stop;
            defoffset{1}=num2str(oldParameters.WindowsSelection.Offset);
        else
            defanswer={' ';' '};
            defoffset={'0'};
        end
        
        answer = inputdlg(prompt,dlg_title,num_lines,defanswer, options);
        LabelForStartEvent=answer{1};
        LabelForStopEvent=answer{2};
        
        prompt='Insert Frame Offset before choosen Events';
        num_lines = 1;
        options.Resize='on';
        options.WindowStyle='modal';
        
        answer = inputdlg(prompt,'Analysis Window Offset from choosen Events',num_lines,defoffset,options);
        
       % eval(['WindowSelectionProcedure.' method '.Leg=leg;'])
        eval(['WindowSelectionProcedure.' method '.FullLabelForStartEvent=LabelForStartEvent;'])
        eval(['WindowSelectionProcedure.' method '.FullLabelForStopEvent=LabelForStopEvent;'])
        eval(['WindowSelectionProcedure.' method '.Offset=answer{1};'])
        
    case 'Manual'
        
        clear prompt
        prompt{1}='Insert Start Frame';
        prompt{2}='Insert End Frame';
        num_lines = 1;
        options.Resize='on';
        options.WindowStyle='modal';
        
        for i=1:length(trialsList)
            
            TrialWindow{i}.TrialName= trialsList{i};
            
            if (nargin > 3 && strcmp(InitialValue.WindowsSelection.Method,'Manual')==1) %if  previous Elaboration.xml has been load
                try
                    def_events(1) = {num2str(oldParameters.WindowsSelection.Events{i}(1))};
                    def_events(2) = {num2str(oldParameters.WindowsSelection.Events{i}(2))};
                catch
                    def_events(1)= {' '};
                    def_events(2)= {' '};
                end
            else
                def_events(1)= {' '};
                def_events(2)= {' '};
                
            end
            
            answer = inputdlg(prompt,TrialWindow{i}.TrialName,num_lines,def_events,options);
            TrialWindow{i}.StartFrame=str2num(answer{1});
            TrialWindow{i}.EndFrame=str2num(answer{2});
           
        end
        
        if length(trialsList)==1
             eval(['WindowSelectionProcedure.' method '.TrialWindow=TrialWindow;'])
        else
            eval(['WindowSelectionProcedure.' method '=TrialWindow;'])
        end
end


%% ---------------------Markers List for .trc file--------------------------            
%Selection of Markers to be written in the trc file
[markersIndex,v] = listdlg('PromptString','Select markers to write in .trc file:',...
                'SelectionMode','multiple',...
                'ListString',MarkersSet,...
                'InitialValue', InitialValue.MarkersList);
            
MarkersList=MarkersSet(markersIndex);

%--------------------------------------------------------------------------
%% ---------------Elaboration structure definition ------------------------

%FolderName
%necessary to have "InputData" in the path
ind=strfind(foldersPath.inputData, 'InputData');
elaboration.FolderName=['.' filesep foldersPath.inputData(ind:end)];

%Trials List
Trials=[];
for i=1:length(trialsList)
    Trials=[Trials trialsList{i} ' '];
end

elaboration.Trials=Trials;

%Markers Interpolation
elaboration.MarkersInterpolation.MaxGapSize=MaxGapSize_default;

%Filtering Parameters

if (exist('m_fcut','var') || exist('f_fcut','var'))

    for i=1:length(trialsList)
        
        elaboration.Filtering.Trial(i).Name=trialsList{i};
        
        if strcmp(fcMarkersChoice,'Yes')==1
            elaboration.Filtering.Trial(i).Fcut.Markers=m_fcut(i);
        end
        if strcmp(fcForcesChoice,'Yes')==1
            elaboration.Filtering.Trial(i).Fcut.Forces=f_fcut(i);
        end
        if exist('cop_fcut','var')
            elaboration.Filtering.Trial(i).Fcut.CenterOfPressure=cop_fcut(i);
        end
    end
end

%WindowSelectionProcedure
elaboration = setfield(elaboration, 'WindowSelectionProcedure', WindowSelectionProcedure);

%Markers
Markers=[];
for i=1:length(MarkersList)
    Markers=[Markers MarkersList{i} ' '];
end

elaboration.Markers=Markers;

%--------------------------------------------------------------------------
%% -------------------------- EMGs Selection ------------------------------
%if EMG signals have been acquired
%if (isfield(acquisitionInfo, 'EMGsProtocol') && isempty(AnalogDataLabels)==0) 
if true(EMGfound)
    
    originalPath=pwd;
    cd('..')
    cd('..')
    
    EMGApplicationLabelsPath=[pwd filesep fullfile('SetupFiles','DataProcessing','EMGsLabels') filesep];
    
    cd(EMGApplicationLabelsPath)
    
    if nargin>3
        oldFileName=[oldElaboration.EMGsSelection.EMGSet];
        [EMGApplicationLabelsFile] = uigetfile([EMGApplicationLabelsPath filesep '*.xml'],'Select the .xml file for the EMG Output Labeling',[oldFileName '.xml']);
    else
        [EMGApplicationLabelsFile] = uigetfile([EMGApplicationLabelsPath filesep '*.xml'],'Select the .xml file for the EMG Output Labeling');
    end
    
    cd (originalPath)
    
    Pref.ReadAttr=false;
    EMGSet=xml_read([EMGApplicationLabelsPath EMGApplicationLabelsFile],Pref);

    load([foldersPath.sessionData 'AnalogDataLabels.mat']);
    
    j=1;
    for i=1:length(EMGSet.EMG)

        EMGLabelsIndex(i)=find(strcmp(EMGSet.EMG(i).C3DLabel,AnalogDataLabels));
        if isempty(EMGLabelsIndex(i))==0
            
            EMGsSelectionList{j}=EMGSet.EMG(i).OutputLabel;
            EMGsSelectionC3DList{j}=EMGSet.EMG(i).C3DLabel;
            j=j+1;
        end
        
    end
    
    %Here because necessary to have EMGSelectionList
    if nargin>3
        InitialValue.EMGsIndexes=findIndexes(EMGsSelectionList,oldParameters.EMGsSelected.OutputLabels);
    else
        InitialValue.EMGsIndexes=[];
    end
    %EMGsOutputList
    [EMGsIndexes,v] = listdlg('PromptString','Select EMGs:',...
        'SelectionMode','multiple',...
        'ListString',EMGsSelectionList,...
        'ListSize',[250 300],...
        'InitialValue',InitialValue.EMGsIndexes);
    
    selectedOutputLabels=EMGsSelectionList(EMGsIndexes);
    selectedC3DLabels=EMGsSelectionC3DList(EMGsIndexes);
    
    %% ----------------------Trials for EMG MAX computation---------------------
    [MaxEmgTrialsIndex,v] = listdlg('PromptString','Select trials to Max EMG computation:',...
        'SelectionMode','multiple',...
        'ListString',trialsName,...
        'InitialValue',InitialValue.emgMaxTrials);
    
    MaxEmgTrialsList=trialsName(MaxEmgTrialsIndex);


    %% ------------------Elaboration structure definition------------------
    %EMGMaxTrials
    EMGMaxTrials=[];
    for i=1:length(MaxEmgTrialsList)
        EMGMaxTrials=[EMGMaxTrials MaxEmgTrialsList{i} ' '];
    end
    
    elaboration.EMGMaxTrials=EMGMaxTrials;
    
    %EMG Selection
    elaboration.EMGsSelection.EMGSet=EMGApplicationLabelsFile(1:end-4);
    for i=1:length(selectedOutputLabels)
        elaboration.EMGsSelection.EMGs.EMG(i).OutputLabel=selectedOutputLabels(i);
        elaboration.EMGsSelection.EMGs.EMG(i).C3DLabel=selectedC3DLabels(i);
    end
    %EMG Offset: EMGs are considered an offset before the Analysis Window
    %start frame to allow further applications to account for the
    %electromechanical delay
    %not asked to the user for the moment but saved in the xml file
    elaboration.EMGOffset=0.2;  %set to 200ms

end

elaboration.OutputFileFormats=InitialValue.OutputFileFormats;

%---------------------Elaboration.xml writting-----------------------------
Pref.StructItem=false;  %to not have arrays of structs with 'item' notation
Pref.ItemName='TrialWindow';
xml_write([foldersPath.elaboration 'elaboration.xml'],elaboration,'elaboration',Pref);

save_to_base(1)