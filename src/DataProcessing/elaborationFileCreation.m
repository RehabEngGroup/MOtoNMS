function [] = elaborationFileCreation(foldersPath,trialsName,acquisitionInfo,oldElaboration,varargin)
% Function to generate elaboration.xml file
% Implemented by Alice Mantoan, February 2012, <alice.mantoan@dei.unipd.it>

%create a cell from char values read from acquisition.xml for the selection
%of Markers to be written in the trc file
%needed for trcMarkersIndexes computation within case nargin>3
MarkersSet=textscan(acquisitionInfo.MarkersProtocol.MarkersSet, '%s','delimiter', ' ');
MarkersSet=MarkersSet{1};

load([foldersPath.sessionData 'EMGLabels.mat']);

%Definition of Lists Initial Values
if nargin>3
  
    oldParameters=parametersGeneration(oldElaboration);
    
    %find indexes for the listdlg command
    trialsIndexes=findIndexes(trialsName,oldParameters.trialsList);    
    trcMarkersIndexes=findIndexes(MarkersSet,oldParameters.trcMarkersList);
    emgMaxTrialsIndexes=findIndexes(trialsName,oldParameters.MaxEmgTrialsList);
    
    InitialValue.Trials=trialsIndexes;
    InitialValue.WindowsSelection.Method=oldParameters.WindowsSelection.Method; 
    InitialValue.MarkersList=trcMarkersIndexes;
    InitialValue.emgMaxTrials=emgMaxTrialsIndexes;
    
else
    InitialValue.Trials=[];
    InitialValue.emgMaxTrials=[];
    InitialValue.MarkersList=[];
    InitialValue.WindowsSelection.Method='.';
end


%% --------------------------Trials Selection-------------------------------
 
[trialsIndex,v] = listdlg('PromptString','Select trials to elaborate:',...
                'SelectionMode','multiple',...
                'ListString',trialsName,...
                'InitialValue',InitialValue.Trials);
            
trialsList=trialsName(trialsIndex);         

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
                    case 'DEI-UNIPD'
                        def_m{i}='7';
                        def_f{i}='7';
                        def_cop{i}='7'; %corresponding to wn=0.0146 and sampling rate=1000
                        
                    case 'UWA'
                        def_m{i}='8';
                        def_f{i}='8';
                        %def_cop{i}='0'; not necessary cop filtering
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

%Leg Definition
InstrumentedLeg=acquisitionInfo.EMGsProtocol.InstrumentedLeg;

if (strcmp(InstrumentedLeg,'Both') || strcmp(InstrumentedLeg,'None'))
    
    legList={'.','Left', 'Right'};
    [legIndex,v] = listdlg('PromptString','Choose Leg to Analyse',...
        'SelectionMode','single',...
        'ListString',legList,...
        'ListSize',[250 100]);
    leg=legList(legIndex);
    
else
    leg=InstrumentedLeg;
end

%Windows Selection Procedure Struct Definition

WindowSelectionProcedure=struct;

switch method
    
    case 'ComputeStancePhase'
               
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
        
        eval(['WindowSelectionProcedure.' method '.Offset=answer{1};'])  
        eval(['WindowSelectionProcedure.' method '.Leg=leg;'])
        

    case 'StanceOnFPfromC3D'
        
        clear prompt
        
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
        prompt{1} = 'Insert Label for Start Event';
        prompt{2}= 'Insert Label for Stop Event';
        
        num_lines =1;
    
        if (nargin > 3 && strcmp(InitialValue.WindowsSelection.Method,'WindowFromC3D')==1) %if  previous Elaboration.xml has been load
            defanswer{1}=oldParameters.WindowsSelection.Labels.Start;
            defanswer{2}=oldParameters.WindowsSelection.Labels.Stop;
        else
            defanswer={' ';' '};
        end
        
        answer = inputdlg(prompt,dlg_title,num_lines,defanswer, options);
        LabelForStartEvent=answer{1};
        LabelForStopEvent=answer{2};
        
        eval(['WindowSelectionProcedure.' method '.Leg=leg;'])
        eval(['WindowSelectionProcedure.' method '.LabelForStartEvent=LabelForStartEvent;'])
        eval(['WindowSelectionProcedure.' method '.LabelForStopEvent=LabelForStopEvent;'])
        
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

%% --------------------------EMGs Selection---------------------------------
%if EMG signals have been acquired
if (isfield(acquisitionInfo, 'EMGsProtocol') && isempty(EMGLabels)==0) 
    originalPath=pwd;
    cd('..')
    cd('..')
    
    EMGApplicationLabelsPath=[pwd '\ConfigurationFiles\DataProcessing\EMGsLabels\'];
    
    cd(EMGApplicationLabelsPath)
    
    if nargin>3
        oldFileName=[oldElaboration.EMGsSelection.EMGSet];
        [EMGApplicationLabelsFile] = uigetfile([EMGApplicationLabelsPath '/*.xml'],'Select the .xml file for the EMG Output Labeling',[oldFileName '.xml']);
    else
        [EMGApplicationLabelsFile] = uigetfile([EMGApplicationLabelsPath '/*.xml'],'Select the .xml file for the EMG Output Labeling');
    end
    
    cd (originalPath)
    
    Pref.ReadAttr=false;
    EMGSet=xml_read([EMGApplicationLabelsPath EMGApplicationLabelsFile],Pref);

    j=1;
    for i=1:length(EMGSet.EMG)
        save_to_base(1)
        EMGLabelsIndex(i)=find(strcmp(EMGSet.EMG(i).C3DLabel,EMGLabels));
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
end

%% Elaboration structure definition
%FolderName
%necessary to have "InputData" in the path
ind=strfind(foldersPath.inputData, 'InputData');
elaboration.FolderName=['.\' foldersPath.inputData(ind:end)];

%Trials List
Trials=[];
for i=1:length(trialsList)
    Trials=[Trials trialsList{i} ' '];
end

elaboration.Trials=Trials;

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

%EMGMaxTrials
EMGMaxTrials=[];
for i=1:length(MaxEmgTrialsList)
    EMGMaxTrials=[EMGMaxTrials MaxEmgTrialsList{i} ' '];
end

if isfield(acquisitionInfo, 'EMGsProtocol')
    elaboration.EMGMaxTrials=EMGMaxTrials;
    
    %EMG Selection
    elaboration.EMGsSelection.EMGSet=EMGApplicationLabelsFile(1:end-4);
    for i=1:length(selectedOutputLabels)
        elaboration.EMGsSelection.EMGs.EMG(i).OutputLabel=selectedOutputLabels(i);
        elaboration.EMGsSelection.EMGs.EMG(i).C3DLabel=selectedC3DLabels(i);
    end
    %EMG Offset
    %not asked to the user for the moment but saved in the xml file
    elaboration.EMGOffset=1;
end
%---------------------Elaboration.xml writting-----------------------------
Pref.StructItem=false;  %to not have arrays of structs with 'item' notation
Pref.ItemName='TrialWindow';
xml_write([foldersPath.elaboration 'elaboration.xml'],elaboration,'elaboration',Pref);

save_to_base(1)