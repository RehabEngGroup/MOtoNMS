function parameters = parametersGeneration(elaboration,acquisitionInfo,foldersPath,varargin)
% Function to convert settings from elaboration.xml into a parameters.mat    
% struct needed for processing

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

%%  

%trialsList
Trials=elaboration.Trials;    
trialsList=textscan(Trials, '%s');
trialsList=trialsList{1}';   

%trcMarkersList
Markers=elaboration.Markers;    
trcMarkersList=textscan(Markers, '%s');
trcMarkersList=trcMarkersList{1}; 

%Filtering Fcut
if isfield(elaboration,'Filtering')
    for i=1:length(trialsList)
  
        if isfield(elaboration.Filtering.Trial(i).Fcut,'Markers')
            fcut.m{i}=elaboration.Filtering.Trial(i).Fcut.Markers;
        end
        if isfield(elaboration.Filtering.Trial(i).Fcut,'Forces')
            fcut.f{i}=elaboration.Filtering.Trial(i).Fcut.Forces;
        end
        if isfield(elaboration.Filtering.Trial(i).Fcut, 'CenterOfPressure')
            fcut.cop{i}=elaboration.Filtering.Trial(i).Fcut.CenterOfPressure;
        end
    end
end

%WindowSelectionProcedure
method=fieldnames(elaboration.WindowSelectionProcedure);

if (strcmp(method,'Manual')==1 )
    
    for i=1:length(trialsList)
      
      events{i}(1)=elaboration.WindowSelectionProcedure.Manual.TrialWindow(i).StartFrame;
      events{i}(2)=elaboration.WindowSelectionProcedure.Manual.TrialWindow(i).EndFrame;
    end
    
end


%% ------------------Parameters struct Definition----------------------------
% data needed for oldParameters
parameters.trialsList=trialsList; 

if exist('fcut','var')
    parameters.fcut=fcut;
end

parameters.WindowsSelection.Method=method{1};

if (strcmp(method,'Manual')==1 )
    parameters.WindowsSelection.Events=events;
end

if (strcmp(method,'StanceOnFPfromC3D')==1 )
    parameters.WindowsSelection.Labels.HS=elaboration.WindowSelectionProcedure.StanceOnFPfromC3D.LabelForHeelStrike;
    parameters.WindowsSelection.Labels.FO=elaboration.WindowSelectionProcedure.StanceOnFPfromC3D.LabelForToeOff;
    parameters.WindowsSelection.Leg=elaboration.WindowSelectionProcedure.StanceOnFPfromC3D.Leg;
    parameters.WindowsSelection.Offset=elaboration.WindowSelectionProcedure.StanceOnFPfromC3D.Offset;
end

if (strcmp(method,'WindowFromC3D')==1 )
    parameters.WindowsSelection.Labels.Start=elaboration.WindowSelectionProcedure.WindowFromC3D.FullLabelForStartEvent;
    parameters.WindowsSelection.Labels.Stop=elaboration.WindowSelectionProcedure.WindowFromC3D.FullLabelForStopEvent;
    parameters.WindowsSelection.Offset=elaboration.WindowSelectionProcedure.WindowFromC3D.Offset;
end

if (strcmp(method,'ComputeStancePhase')==1 )
    parameters.WindowsSelection.Leg=elaboration.WindowSelectionProcedure.ComputeStancePhase.Leg;
    parameters.WindowsSelection.Offset=elaboration.WindowSelectionProcedure.ComputeStancePhase.Offset;
end

parameters.trcMarkersList=trcMarkersList;

%% If there are EMGs data
if isfield(elaboration,'EMGsSelection')
    
    EMGMaxTrials=elaboration.EMGMaxTrials;
    MaxEmgTrialsList=textscan(EMGMaxTrials, '%s');
    MaxEmgTrialsList=MaxEmgTrialsList{1}';
    
    for i=1:length(elaboration.EMGsSelection.EMGs.EMG)
        
        EMGOutputLabels{i}=elaboration.EMGsSelection.EMGs.EMG(i).OutputLabel;
        EMGC3DLabels{i}=elaboration.EMGsSelection.EMGs.EMG(i).C3DLabel;
    end
    
    %------------------Parameters struct Definition------------------------
    parameters.EMGsSelected.OutputLabels=EMGOutputLabels;
    parameters.EMGsSelected.C3DLabels=EMGC3DLabels;
    
    parameters.MaxEmgTrialsList=MaxEmgTrialsList;
    parameters.EMGOffset=elaboration.EMGOffset;
end

%% -------------------------------------------------------------------------- 
%adding parameters from acquisition and c3d files
%leg is connected to InstrumentedLeg in acquisition.xml file and is not
%needed for oldParameters definition

if nargin>1
    
    %More about WindowSelectionProcedure
    
    if (strcmp(method,'StanceOnFPfromC3D')==1 || strcmp(method,'WindowFromC3D')==1)  %same for both here
        
        events=loadEvents(foldersPath.sessionData,trialsList);
        
        parameters.WindowsSelection.Events=events;
      
        %parameters.WindowsSelection.Leg=eval(['elaboration.WindowSelectionProcedure.' method{1} '.Leg;']); 
    end
       
%     if strcmp(method,'ComputeStancePhase')==1
% 
%         parameters.WindowsSelection.Leg=elaboration.WindowSelectionProcedure.ComputeStancePhase.Leg;
%         parameters.WindowsSelection.Offset=elaboration.WindowSelectionProcedure.ComputeStancePhase.Offset;      
%     end
      
    %---------Parameters definition throught acquisition.xml file--------------
    %StancesOnFP
    for k=1:length(acquisitionInfo.Trials.Trial)
        for i=1:length(acquisitionInfo.Trials.Trial(k).StancesOnForcePlatforms.StanceOnFP)
            AllStancesOnFP{k}(i)=acquisitionInfo.Trials.Trial(k).StancesOnForcePlatforms.StanceOnFP(i);
        end
        
        TrialType{k}=acquisitionInfo.Trials.Trial(k).Type;
        RepetitionNumber{k}=num2str(acquisitionInfo.Trials.Trial(k).RepetitionNumber);
        InitialTrialsList{k}=strcat(TrialType{k},RepetitionNumber{k});
    end
    
    StancesIndexes=findIndexes(InitialTrialsList,trialsList);
    StancesOnFP=AllStancesOnFP(StancesIndexes);
    
    parameters.StancesOnFP=StancesOnFP;
    
    %Read from data struct acquisition info about global orientation
    globalReferenceSystem= acquisitionInfo.Laboratory.CoordinateSystemOrientation;
    
    globalToOpenSimRotations=globalToOpenSimRotParametersCreator(globalReferenceSystem);
    
    parameters.globalReferenceSystem=globalReferenceSystem;
    parameters.globalToOpenSimRotations=globalToOpenSimRotations;
       
    for j=1:acquisitionInfo.Laboratory.NumberOfForcePlatforms
        
        for i=1: length(acquisitionInfo.Laboratory.ForcePlatformsList.ForcePlatform(j).FPtoGlobalRotations.Rot)
            FProtations{j}(i)=acquisitionInfo.Laboratory.ForcePlatformsList.ForcePlatform(j).FPtoGlobalRotations.Rot(i);
        end

        FPtoGlobalRotationsParameters(j) = FPtoGlobalRotParameterStructCreator(FProtations{j});
        
        parameters.FPtoGlobalRotations(j)=FPtoGlobalRotationsParameters(j);
    end 
  
    %--------------------------------------------------------------------------        
    save ([foldersPath.elaboration '\parameters.mat'], 'parameters')
end

