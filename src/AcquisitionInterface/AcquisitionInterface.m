%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               MOtoNMS                                   %
%                MATLAB MOTION DATA ELABORATION TOOLBOX                   %
%                 FOR NEUROMUSCULOSKELETAL APPLICATIONS                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AcquisitionInterface.m
% GUI for acquisition.xml file generation.

% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
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

%%

function [] = AcquisitionInterface(oldAcquisition)

%% -----------------------------------------------------------------------%
%        Definition of oldAcquisition Values for loading old file         %
%-------------------------------------------------------------------------%
if nargin>0

    %Staff
    def_staff=setStaffValuesFromFile(oldAcquisition);
    %Subject
    def_subject=setSubjectValuesFromFile(oldAcquisition);
    %AcquisitionDate
    def_AcqDate=setAcqDateFromFile(oldAcquisition);
    %VideoFrameRate
    def_VRate=setVideoFrameRateFromFile(oldAcquisition);
    %def_NumEmgSystems{1}=num2str(oldAcquisition.EMGSystems.Number);
    if isfield(oldAcquisition,'EMGs')==1
        def_NumEmgSystems{1}=num2str(length(oldAcquisition.EMGs.Systems.System));
    else
        def_NumEmgSystems{1}='0';
    end
    %StancesOnFP
    %def_String=setTrialsStancesFromFile(nTrails,oldAcquisition);
else
    
    def_staff=setStaffValuesFromFile();
    def_subject=setSubjectValuesFromFile();
    def_AcqDate=setAcqDateFromFile();
    def_VRate=setVideoFrameRateFromFile();
    def_NumEmgSystems={'1'};
    %def_String=setTrialsStancesFromFile();
end

%% Prompt definition

num_lines = 1;
options.Resize='on';
options.WindowStyle='modal';

%% Dataset folder
DataSetPath = uigetdir(' ','Select your dataset folder');


%% -----------------------------------------------------------------------%
%                               LABORATORY                                %
%-------------------------------------------------------------------------%
originalPath=pwd;
cd('..')
cd('..')

laboratoryPath=[pwd '\SetupFiles\AcquisitionInterface\Laboratories\'];   
cd (originalPath)

if nargin>0
    [laboratoryName] = uigetfile([ '/*.xml'],'Select the .xml file corresponding to the lab',[laboratoryPath oldAcquisition.Laboratory.Name '.xml']);
else
    [laboratoryName] = uigetfile([laboratoryPath '/*.xml'],'Select the .xml file corresponding to the lab');
end

Pref.ReadAttr=false;
Laboratory=xml_read([laboratoryPath laboratoryName],Pref);

%% -----------------------------------------------------------------------%
%                               STAFF                                     %
%-------------------------------------------------------------------------%
      
prompt{1}='Person In Charge (Required)';
prompt{2}='Operators';
prompt{3}='Operators';
prompt{4}='Physiotherapists';
answer = inputdlg(prompt,'Staff',num_lines,def_staff,options);
  
Staff.PersonInCharge=char(answer{1});
if isempty(answer{2})==0
    Staff.Operators.Name{1}=char(answer{2}); %char needed if answer is empty({[]})
end
if isempty(answer{3})==0
    Staff.Operators.Name{2}=char(answer{3});    
end
if isempty(answer{4})==0
    Staff.Physiotherapists.Name=char(answer{4});
end

%% -----------------------------------------------------------------------%
%                               SUBJECT                                   %
%-------------------------------------------------------------------------% 
clear prompt 

prompt{1}='First Name';
prompt{2}='Last Name';
prompt{3}='Code';
prompt{4}='BirthDate(year-month-day)';
prompt{5}='Age';
prompt{6}='Weight';
prompt{7}='Height';
prompt{8}='FootSize';
prompt{9}='Pathology';

answer = inputdlg(prompt,'Subject',num_lines,def_subject,options);
  
Subject.FirstName=char(answer{1});
Subject.LastName=char(answer{2});
Subject.Code=char(answer{3});
Subject.BirthDate=char(answer{4});
Subject.Age=str2num(answer{5});
Subject.Weight=str2num(answer{6});
Subject.Height=str2num(answer{7});
Subject.FootSize=str2num(answer{8});
Subject.Pathology=char(answer{9});

%% -----------------------------------------------------------------------%
%                          ACQUISITION DATE                               %
%-------------------------------------------------------------------------%
clear prompt 

prompt{1}='Acquisition Date (year-month-day)';

answer= inputdlg(prompt,'Insert Acqusition Date',num_lines,def_AcqDate,options);
AcquisitionDate=char(answer{1});

%% -----------------------------------------------------------------------%
%                          VIDEO FRAME RATE                               %
%-------------------------------------------------------------------------%
clear prompt 

prompt{1}='Video Frame Rate';

answer= inputdlg(prompt,'Insert Video Frame Rate',num_lines,def_VRate,options);
VideoFrameRate=str2num(answer{1});

%% -----------------------------------------------------------------------%
%                          MARKERS PROTOCOL                               %
%-------------------------------------------------------------------------%
originalPath=pwd;
cd('..')
cd('..')

markersProtocolPath=[pwd '\SetupFiles\AcquisitionInterface\MarkersProtocols\'];   

cd(markersProtocolPath)
if nargin>0
    [markersProtocolName] = uigetfile([markersProtocolPath '/*.xml'],'Select the .xml file corresponding to the Markers Protocol',[oldAcquisition.MarkersProtocol.Name '.xml']);
else
    [markersProtocolName] = uigetfile([markersProtocolPath '/*.xml'],'Select the .xml file corresponding to the Markers Protocol');
end
cd (originalPath)

Pref.ReadAttr=false;
MarkersProtocol=xml_read([markersProtocolPath markersProtocolName],Pref);


%% -----------------------------------------------------------------------%
%                           EMGs SYSTEMS                                  %
%-------------------------------------------------------------------------%

clear prompt def
prompt{1}='Number of EMGs System Used';
%def{1}='1';
answer = inputdlg(prompt,'Number of EMGs System Used',num_lines,def_NumEmgSystems,options);

nEMGSystem=str2num(answer{1});

if isempty(nEMGSystem)
    m=msgbox('Number Of EMG System MUST be inserted!Try again!','EMG Systems','warn');
    uiwait(m)
    answer = inputdlg(prompt,'Number of EMGs System Used',num_lines,def,options);
    
    nEMGSystem=str2num(answer{1});
end

if nEMGSystem>0 
    if nargin>0
        %EMGSystem
        def_EMGSystems=setEMGSystemFromFile(nEMGSystem,oldAcquisition);
    else
        def_EMGSystems=setEMGSystemFromFile(nEMGSystem);
    end
    
    clear prompt
    TotNumberOfChannels=0;
    
    for k=1:nEMGSystem
        
        prompt{1}='Name';
        prompt{2}='Rate';
        prompt{3}='Number Of Used Channels';
        
        def_EMGSystem{1}=def_EMGSystems{k,1};
        def_EMGSystem{2}=def_EMGSystems{k,2};
        def_EMGSystem{3}=def_EMGSystems{k,3};
        
        answer = inputdlg(prompt,'EMGs System',num_lines,def_EMGSystem,options);
        
        EMGSystem(k).Name=answer{1};
        EMGSystem(k).Rate=str2num(answer{2});
        EMGSystem(k).NumberOfChannels=str2num(answer{3});
        
        TotNumberOfChannels=TotNumberOfChannels+EMGSystem(k).NumberOfChannels;
    end
    
    if isempty(TotNumberOfChannels)
        m=msgbox('Number Of EMG Channels MUST be inserted!Try again!','EMG Channels','warn');
        uiwait(m)
        clear prompt
        prompt{1}='Number Of Used Channels';
        TotNumberOfChannels=0;
        for k=1:nEMGSystem
            answer = inputdlg(prompt,'EMGs System',num_lines,{' '},options);
            EMGSystem(k).NumberOfChannels=str2num(answer{1});
            TotNumberOfChannels=TotNumberOfChannels+EMGSystem(k).NumberOfChannels;
        end
    end
    %% -------------------------------------------------------------------%
    %                           EMGs PROTOCOL                             %
    %---------------------------------------------------------------------%
    
    originalPath=pwd;
    cd('..')
    cd('..')
    
    EMGsProtocolPath=[pwd '\SetupFiles\AcquisitionInterface\EMGsProtocols\'];
    
    cd(EMGsProtocolPath)
    if nargin>0
        [EMGsProtocolName] = uigetfile([EMGsProtocolPath '/*.xml'],'Select the .xml file corresponding to the EMGs Protocol',[oldAcquisition.EMGs.Protocol.Name '.xml']);
    else
        [EMGsProtocolName] = uigetfile([EMGsProtocolPath '/*.xml'],'Select the .xml file corresponding to the EMGs Protocol');
    end
    cd (originalPath)
    
    Pref.ReadAttr=false;
    EMGsProtocol=xml_read([EMGsProtocolPath EMGsProtocolName],Pref);
    
    %% -------------------------------------------------------------------%
    %                              CHANNELS                               %
    %---------------------------------------------------------------------%
    clear prompt
    
    prompt{1}='Channel ID (Required)';
    prompt{2}='Muscle';
    prompt{3}='Footswitch ID';
    prompt{4}='FootSwitch Position';
    
    %muscleList=EMGsProtocol.MuscleList;
    % MuscleList=textscan(muscleList, '%s');
    % MuscleList=MuscleList{1}';
    for j=1:length(EMGsProtocol.MuscleList.Muscle)
        MuscleList{j}=EMGsProtocol.MuscleList.Muscle{j};
    end
    
    for i=1:TotNumberOfChannels
        
        if nargin>0
            def_channel=setChannelFromFile(i,MuscleList,oldAcquisition);
        else
            def_channel=setChannelFromFile(i,MuscleList);
        end
        
        answer = inputdlg(prompt,['Channel ' num2str(i)],num_lines,def_channel,options);
        
        if isempty(answer{1})==0
            Channel(i).ID=answer{1};
            
            if isempty(answer{2})==0
                Channel(i).Muscle=answer{2};
            end
            if isempty(answer{3})==0
                Channel(i).FootSwitch.ID=answer{3};
                Channel(i).FootSwitch.Position=answer{4};
            end
        else
            m=msgbox('Channel ID Required!','EMG Channels','warn');
            answer = inputdlg(prompt,['Channel ' num2str(i)],num_lines,def_channel,options);
            uiwait(m)
        end
        clear def_channel
    end
    
    Channels.Channel=Channel';
end
%% -----------------------------------------------------------------------%
%                              TRIALS                                     %
%-------------------------------------------------------------------------%
%Trials Name
c3dFiles = dir ([DataSetPath '\*.c3d']);

nTrials=length(c3dFiles);

%Def values
if nargin>0
    def_String=setTrialsStancesFromFile(nTrials,oldAcquisition);
else
    def_String=setTrialsStancesFromFile(nTrials);
end

nRep{1}='0';
nRep{2}='1';
nRep{3}='2';
nRep{4}='3';
nRep{5}='4';
nRep{6}='5';
nRep{7}='6';
nRep{8}='7';
nRep{9}='8';
nRep{10}='9';

scrsz = get(0,'ScreenSize'); %for the figure dimension

for k=1:length(c3dFiles)
    
    ind=[];
    %Name correction/check: after standadization it will not be necessary
    trialsName{k} = regexprep(regexprep((regexprep(c3dFiles(k).name, ' ' , '')), '-',''), '.c3d', '');
    
    for i=1:length(nRep)
        c=strfind(trialsName{k},nRep{i});
        ind=[ind c];
    end
    
    %Trials TYPE and REPETITION
    if isempty(ind)==0
        Trial(k).Type=trialsName{k}(1:ind-1);
        Trial(k).RepetitionNumber=trialsName{k}(ind:end);
    else
        Trial(k).Type=trialsName{k};
        Trial(k).RepetitionNumber='';
    end

    %StancesOnForcePlatforms Definition
    global LegFP1 LegFP2  

    h=figure('Name', 'Trials','Position',[scrsz(4)/2 scrsz(4)/4 scrsz(3)/3 scrsz(4)/3]);
    
    uicontrol('Style','text','Position',[160 190 140 30], 'String',['Type: ' trialsName{k}],'FontSize',9)
    uicontrol('Style','text','Position',[160 140 140 20], 'String',['Repetition: ' Trial(k).RepetitionNumber],'FontSize',9)
    
    uicontrol('Style','text','Position',[10 100 150 20], 'String','Leg on ForcePlatform 1','FontSize',9)

    uicontrol('Style','popupmenu','Position',[10 70 150 20],...
        'String',def_String{k,1},...
        'Callback',{@setLegFP1,def_String{k,1}});
    
    uicontrol('Style','text','Position',[300 100 150 20], 'String','Leg on ForcePlatform 2','FontSize',9)
    uicontrol('Style','popupmenu',...
        'Position',[300 70 120 20],...
        'String',def_String{k,2},...
        'Callback',{@setLegFP2,def_String{k,2}});
    
    uicontrol('Style','pushbutton',...
        'Position',[160 20 140 20],...
        'String','Next',...
        'Callback',{@pushbutton1_Callback});
    
    uiwait(h)
     
    LegFP1=getValue1();
    LegFP2=getValue2();
        
    if isempty(LegFP1) 
        StanceOnFP(1).Forceplatform=1;
        stringChoices1=textscan(def_String{k,1},'%s', 'Delimiter','|');
        StanceOnFP(1).Leg=stringChoices1{1}(1);      
        
    else if strcmp(LegFP1,'-')==0
            StanceOnFP(1).Forceplatform=1;
            StanceOnFP(1).Leg=LegFP1;
        else
            disp(['Trial ' trialsName{k} ': Stance on FP1 data missing'])
        end
    end
    
    if isempty(LegFP2) 
        StanceOnFP(2).Forceplatform=2;
        stringChoices2=textscan(def_String{k,2},'%s', 'Delimiter','|');
        StanceOnFP(2).Leg=stringChoices2{1}(1);
        
    else if strcmp(LegFP2,'-')==0           
            StanceOnFP(2).Forceplatform=2;
            StanceOnFP(2).Leg=LegFP2;         
        else
            disp(['Trial ' trialsName{k} ': Stance on FP1 data missing'])
        end
    end
    
    Trial(k).StancesOnForcePlatforms.StanceOnFP=StanceOnFP;

    clear StanceOnFP
end

Trials.Trial=Trial;


%% -----------------------------------------------------------------------%
%                         ACQUISITION STRUCT                              %
%-------------------------------------------------------------------------%
ATTRIBUTE.xmlns_COLON_xsi='http://www.w3.org/2001/XMLSchema';

acquisition.Laboratory=Laboratory;
acquisition.Staff=Staff;
acquisition.Subject=Subject;
acquisition.AcquisitionDate=AcquisitionDate;
acquisition.VideoFrameRate=VideoFrameRate;
acquisition.MarkersProtocol=MarkersProtocol;
%acquisition.EMGSystems.Number=nEMGSystem;
if nEMGSystem>0
    acquisition.EMGs.Systems.System=EMGSystem;
    acquisition.EMGs.Protocol=EMGsProtocol;
    acquisition.EMGs.Channels=Channels;
end
acquisition.Trials=Trials;
acquisition.ATTRIBUTE=ATTRIBUTE;

%% -----------------------------------------------------------------------%
%                     acquisition.xml WRITING                             %
%-------------------------------------------------------------------------%
Pref.StructItem=false;  %to not have arrays of structs with 'item' notation
Pref.ItemName='Muscle';
Pref.CellItem=false;

xml_write([DataSetPath '\acquisition.xml'],acquisition,'acquisition',Pref);

disp('Any missing information will prevent .xml validation with its .xsd');

save_to_base(1)    %Allow to copy variables in the workspace