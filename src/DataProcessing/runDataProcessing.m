%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               MOtoNMS                                   %
%                MATLAB MOTION DATA ELABORATION TOOLBOX                   %
%                 FOR NEUROMUSCULOSKELETAL APPLICATIONS                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% runDataProcessing.m: Data Processing main function

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

function []=runDataProcessing(ElaborationFilePath)

if nargin==0
    error('elaboration.xml file path missing: it must be given as a function input')
end

addSharedPath()

h = waitbar(0,'Elaborating data...Please wait!');

%% -----------------------PROCESSING SETTING-------------------------------
% Acquisition info loading, folders paths and parameters generation
%--------------------------------------------------------------------------

[foldersPath,parameters]= DataProcessingSettings(ElaborationFilePath);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                      OPENSIM Files Generation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Parameters List: Ri-nomination 
trialsList=parameters.trialsList; 
maxGapSize=parameters.interpolationMaxGapSize;

if isfield(parameters,'fcut')
    fcut=parameters.fcut;
end

WindowsSelection=parameters.WindowsSelection;
StancesOnFP=parameters.StancesOnFP;

trcMarkersList=parameters.trcMarkersList;

globalToOpenSimRotations=parameters.globalToOpenSimRotations;
FPtoGlobalRotations=parameters.FPtoGlobalRotations;

motionDirections=parameters.motionDirection;

if isfield(parameters,'OutputFileFormats')
    MarkerOFileFormat=parameters.OutputFileFormats.MarkerTrajectories;
    GRFOFileFormat=parameters.OutputFileFormats.GRF;
else
    MarkerOFileFormat='.trc'; %set default output format
    GRFOFileFormat='.mot';
end
    
%Create Trails Output Dir
foldersPath.trialOutput= mkOutputDir(foldersPath.elaboration,trialsList);

%% ------------------------------------------------------------------------
%                            DATA LOADING 
%                   .mat data from SessionData Folder
%--------------------------------------------------------------------------
%loadMatData includes check for markers unit (if 'mm' ok else convert)
%Frames contains indication of first and last frame of labeled data, that
%must be the same for Markers and Analog Data and depends on the tracking
%process
%MarkersLabels MUST be the same for all dynamic trials BUT the order change
%according to the tracking process. Therefore, it's necessary to load them 
%for each trial to corretly select markers   
[MarkersRawData, MarkersLabels, Frames]=loadMatData(foldersPath.sessionData, trialsList, 'Markers');
FPRawData=loadMatData(foldersPath.sessionData, trialsList, 'FPdata');

%Loading FrameRates
load([foldersPath.sessionData 'Rates.mat']) 

VideoFrameRate=Rates.VideoFrameRate;
AnalogFrameRate=Rates.AnalogFrameRate;

%Loading ForcePlatformInfo
load([foldersPath.sessionData 'ForcePlatformInfo.mat'])
nFP=length(ForcePlatformInfo);

if isfield(parameters,'platesPad')
    padsThickness=parameters.platesPad;
else
    padsThickness=zeros(1,nFP);
end

%Loading AllTrialsName
load([foldersPath.sessionData 'trialsName.mat'])

%Loading All Markers Labels (Raw)
%NOTE: the order change according to the tracking process, so it might be
%useful to know the markers used in the acquisition session but it can't be 
%used to select markers for each trial
%load([foldersPath.sessionData 'dMLabels.mat'])

disp('Data have been loaded from mat files')         

%% ------------------------------------------------------------------------
%                     Preparing Data for Filtering
%--------------------------------------------------------------------------

%-------------------------Markers Selection--------------------------------
%markers to be written in the trc file: only those are processed
for k=1:length(trialsList)
    markerstrc{k} = selectingMarkers(trcMarkersList,MarkersLabels{k},MarkersRawData{k});
end
%-----------Check for markers data missing and Interpolation--------------

[MarkersNan,index]=replaceMissingWithNaNs(markerstrc); 
 
%if there are no missing markers, it doesn't interpolate
[interpData,note] = DataInterpolation(MarkersNan, index, maxGapSize);
 
writeInterpolationNote(note,foldersPath.trialOutput);
%interpData=markerstrc;

%------------------------Analog Data Split---------------------------------
%Analog data are organized like this:
%ForcePlatform type 1: [Fx1 Fy1 Fz1 Px1 Py1 Mz1 Fx2 Fy2 Fz2 Px2 Py2 Mz2...]
%ForcePlatform type 2: [Fx1 Fy1 Fz1 Mx1 My1 Mz1 Fx2 Fy2 Fz2 Mx2 My2 Mz2...]
%ForcePlatform type 3: [F1x12 F1y23 F1y14 F1y23 F1z1 F1z2 F1z3 F1z4 ...]
%ForcePlatform type 4: [Fx1 Fy1 Fz1 Mx1 My1 Mz1 Fx2 Fy2 Fz2 Mx2 My2 Mz2..]
%Separation of information for different filtering taking into account
%differences in force platform type

[Forces,Moments,COP]= AnalogDataSplit(FPRawData,ForcePlatformInfo);

waitbar(1/7);    

%% ------------------------------------------------------------------------
%                         DATA FILTERING 
%--------------------------------------------------------------------------
%filter parameters: only fcut can change, order and type of filter is fixed
%Output: structure with filtered data from all selected trials

%----------------------------Markers---------------------------------------
if (exist('fcut','var') && isfield(fcut,'m'))
   %filtMarkers=DataFiltering(MarkersRawData,VideoFrameRate,fcut.m);
   filtMarkers=DataFiltering(interpData,VideoFrameRate,fcut.m,index);
   %filtMarkersCorrected=correctBordersAfterFiltering(filtMarkers,interpData,index);
   %filtMarkersCorrected=filtMarkers;
else
    filtMarkers=interpData;
    %filtMarkersCorrected=interpData;
    %filtMarkersCorrected=MarkersRawData;
    %filtMarkersCorrected=markerstrc;
end
 
%----------------------------Analog Data-----------------------------------
checkFPsType(ForcePlatformInfo)
%assumptions: 
% -FPs can be of different types ONLY if type 1 is not included (i.e. there 
%can be FPs of type 2,3,4 together OR all of type 1).
%Data from FP of type 1 require a different elaboration, but at this point
%data from all the FPs are grouped togheter so that it is not possible to
%process them differently without changing the main structure of the code.

switch ForcePlatformInfo{1}.type   %assumption: FPs are of the same type
    
    case {2,3,4}
        
        if (exist('fcut','var') && isfield(fcut,'f'))
            filtForces=DataFiltering(Forces,AnalogFrameRate,fcut.f);
            filtMoments=DataFiltering(Moments,AnalogFrameRate,fcut.f);
        else
            filtForces=Forces;
            filtMoments=Moments;
        end
        
        %In this case, COP have to be computed
        %Necessary Thresholding for COP computation
        [ForcesThr,MomentsThr]=FzThresholding(filtForces,filtMoments);
        
        for k=1:length(filtMoments)
            for i=1:nFP
                COP{k}(:,:,i)=computeCOP(ForcesThr{k}(:,:,i),MomentsThr{k}(:,:,i), ForcePlatformInfo{i}, padsThickness(i));
            end
        end
        
        filtCOP=COP; %not necessary to filter the computed cop
        

    case 1   %Padova type: it returns Px & Py
        
        if (exist('fcut','var'))
            
            if isfield(fcut,'f')
                
                filtForces=filteringDataFPtype1(Forces,AnalogFrameRate,fcut.f,'Forces');
                filtMoments=filteringDataFPtype1(Moments,AnalogFrameRate,fcut.f,'Moments');
                
            else
                filtForces=Forces;
                filtMoments=Moments;
            end
            
            if isfield(fcut,'cop')
                
                filtCOP=filteringDataFPtype1(COP,AnalogFrameRate,fcut.cop,'COP');
            else
                filtCOP=COP;
            end
            
        else
            filtForces=Forces;
            filtMoments=Moments;
            filtCOP=COP;
        end
        %Threasholding also here for uniformity among the two cases
        [ForcesThr,MomentsThr]=FzThresholding(filtForces,filtMoments);
end


disp('Data have been filtered')
%For next steps, only filtered data are kept                                                  
%clear MarkersRawData ForcesRawData AnalogRawData
waitbar(2/7);   
%% ------------------------------------------------------------------------
%                      START/STOP COMPUTATION
%--------------------------------------------------------------------------
%Different AnalysisWindow computation methods may be implemented according
%to the application
%To select the AnalysisWindow, noise Thresholded Forces are used
AnalysisWindow=AnalysisWindowSelection(WindowsSelection,StancesOnFP,filtForces,Frames,Rates);

saveAnalysisWindow(foldersPath.trialOutput,AnalysisWindow)

%% ------------------------------------------------------------------------
%                        DATA WINDOW SELECTION
%--------------------------------------------------------------------------
%[MarkersFiltered,Mtime]=selectionData(filtMarkersCorrected,AnalysisWindow,VideoFrameRate);
[MarkersFiltered,Mtime]=selectionData(filtMarkers,AnalysisWindow,VideoFrameRate);
[ForcesFiltered,Ftime]=selectionData(ForcesThr,AnalysisWindow,AnalogFrameRate);
[MomentsFiltered,Ftime]=selectionData(MomentsThr,AnalysisWindow,AnalogFrameRate);
[COPFiltered,Ftime]=selectionData(filtCOP,AnalysisWindow,AnalogFrameRate);

%DataRaw selection for plotting
[ForcesSelected]=selectionData(Forces,AnalysisWindow,AnalogFrameRate);
[MomentsSelected]=selectionData(Moments,AnalysisWindow,AnalogFrameRate);
[COPSelected]=selectionData(COP,AnalysisWindow,AnalogFrameRate);

%% --------------------------------------------------------------------------
%                           Results plotting
%--------------------------------------------------------------------------
ResultsVisualComparison(ForcesSelected,ForcesFiltered,foldersPath.trialOutput,'Forces')
ResultsVisualComparison(MomentsSelected,MomentsFiltered,foldersPath.trialOutput,'Moments')
ResultsVisualComparison(COPSelected,COPFiltered,foldersPath.trialOutput,'COP')

%% ------------------------------------------------------------------------
%                     SAVING Filtered Selected Data
%--------------------------------------------------------------------------
saveFilteredData(foldersPath.trialOutput, Mtime, MarkersFiltered,'Markers')
saveFilteredData(foldersPath.trialOutput, Ftime, ForcesFiltered,'Forces')
saveFilteredData(foldersPath.trialOutput, Ftime, MomentsFiltered,'Moments')
saveFilteredData(foldersPath.trialOutput, Ftime, COPFiltered,'COP')
waitbar(3/7);   

%% ------------------------------------------------------------------------
%                           WRITE TRC
%--------------------------------------------------------------------------

%MarkersFilteredNaN=replaceMissingWithNaNs(MarkersFiltered);
%load([foldersPath.sessionData 'dMLabels.mat'])
if strcmp(MarkerOFileFormat, '.trc')
    for k=1:length(trialsList)
        
        FullFileName=[foldersPath.trialOutput{k} trialsList{k} '.trc'];
        %markers selection anticipates at the beginning to avoid processing
        %useless data and problems with interpolation
        %markerstrc = selectingMarkers(trcMarkersList,dMLabels,MarkersFiltered{k});
        %createtrc(markerstrc,Mtime{k},trcMarkersList,globalToOpenSimRotations,VideoFrameRate,FullFileName)
        %createtrc(MarkersFilteredNaN{k},Mtime{k},trcMarkersList,globalToOpenSimRotations,VideoFrameRate,FullFileName)
        
        rotatedMarkers{k}=RotateCS(MarkersFiltered{k},globalToOpenSimRotations);

        %accounting for the possibility of different directions of motion
        markersMotionDirRotOpenSim{k}=rotatingMotionDirection(motionDirections{k},rotatedMarkers{k});
        
        %createtrc(MarkersFiltered{k},Mtime{k},trcMarkersList,globalToOpenSimRotations,VideoFrameRate,FullFileName)
        CompleteMarkersData=[Mtime{k} markersMotionDirRotOpenSim{k}];

        writetrc(CompleteMarkersData,trcMarkersList,VideoFrameRate,FullFileName)
        
    end
else
    disp(' ')
    error('ErrorTests:convertTest', ...
        ['----------------------------------------------------------------\nWARNING: WRONG Marker Trajectories Output File Format!\nOnly .trc is available in the current version. Please, check it in your elaboration.xml file'])
end

waitbar(4/7);   
%% ------------------------------------------------------------------------
%                           WRITE MOT
%--------------------------------------------------------------------------

for k=1:length(trialsList)
    
    globalMOTdata{k}=[];
    
    for i=1:nFP
        
        Torques{k}(:,:,i)= computeTorque(ForcesFiltered{k}(:,:,i),MomentsFiltered{k}(:,:,i), COPFiltered{k}(:,:,i), ForcePlatformInfo{i});
        
        globalForces{k}(:,:,i)= RotateCS (ForcesFiltered{k}(:,:,i),FPtoGlobalRotations(i));
        globalTorques{k}(:,:,i)= RotateCS (Torques{k}(:,:,i),FPtoGlobalRotations(i));
        globalCOP{k}(:,:,i) = convertCOPToGlobal(COPFiltered{k}(:,:,i),FPtoGlobalRotations(i),ForcePlatformInfo{i});
        
        globalMOTdata{k}=[globalMOTdata{k} globalForces{k}(:,:,i) globalCOP{k}(:,:,i) ];        
    end
    
    for i=1:nFP
        
        globalMOTdata{k}=[globalMOTdata{k} globalTorques{k}(:,:,i) ];      
    end
      
    %Rotation for OpenSim    
    MOTdataOpenSim{k}=RotateCS (globalMOTdata{k},globalToOpenSimRotations);
    
    %accounting for the possibility of different directions of motion
    MOTrotDataOpenSim{k}=rotatingMotionDirection(motionDirections{k},MOTdataOpenSim{k});
    
    if strcmp(GRFOFileFormat, '.mot')
        
        %Write MOT
        FullFileName=[foldersPath.trialOutput{k} trialsList{k} '.mot'];
        
        writeMot(MOTrotDataOpenSim{k},Ftime{k},FullFileName)
        
    else
        error('ErrorTests:convertTest', ...
            ['----------------------------------------------------------------\nWARNING: WRONG GRF Output File Format!\nOnly .mot is available in the current version. Please, check it in your elaboration.xml file'])
    end
        
end

waitbar(5/7);

save_to_base(1)
% save_to_base() copies all variables in the calling function to the base
% workspace. This makes it possible to examine this function internal
% variables from the Matlab command prompt after the calling function
% terminates. Uncomment the following command if you want to activate it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                           EMG PROGESSING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isfield(parameters,'EMGsSelected')
    
    disp(' ')
    disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
    disp('             EMG PROCESSING                    ')
    disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
    %Data needed:
    %foldersPath,trialsName,trialsList,AnalogRawData,AnalogFrameRate,EMGLabels,
    %AnalysisWindow,EMGOffset,MaxEmgTrialsList,EMGsSelected_C3DLabels,
    %EMGsSelected_OutputLabels
    
    %Ri-nomination from parameters
     
    EMGsSelected_OutputLabels= parameters.EMGsSelected.OutputLabels;
    EMGsSelected_C3DLabels= parameters.EMGsSelected.C3DLabels;
    EMGOffset=parameters.EMGOffset;
    MaxEmgTrialsList=parameters.MaxEmgTrialsList;
    
    if isfield(parameters,'OutputFileFormats')
        EMGOFileFormat=parameters.OutputFileFormats.EMG;
    else
        EMGOFileFormat='.mot';  %default EMG output file format
    end
    
    foldersPath.maxemg=[foldersPath.elaboration filesep 'maxemg'];
    mkdir(foldersPath.maxemg)
    %Loading Analog Raw Data from the choosen trials with the corresponding
    %labels
    [AnalogRawData, AnalogDataLabels, aFrames, aUnits]=loadMatData(foldersPath.sessionData, trialsList, 'AnalogData');
    
    %Loading Analog Raw Data for EMG Max Computation from the trials list
    if isequal(parameters.MaxEmgTrialsList,parameters.trialsList)
        AnalogRawForMax=AnalogRawData;
        AnalogLabelsForMax=AnalogDataLabels;
    else
        [AnalogRawForMax, AnalogLabelsForMax]=loadMatData(foldersPath.sessionData, MaxEmgTrialsList, 'AnalogData');
    end
    
    %Loading Analog Data Labels
    %load([foldersPath.sessionData 'AnalogDataLabels.mat'])
    %NOTE: analog channels configuration may change according to the
    %acquisition procedure (e.g. with Vicon), thus analog labels for each 
    %trial are loaded and used (as for markers)
    
    %If there are EMGs --> processing
    if (isempty(AnalogRawData)==0 && isempty(AnalogDataLabels)==0)
    %% --------------------------------------------------------------------
    %                   EMGs EXTRACTION and MUSCLES SELECTION
    %                   EMGs Arrangement for the Output file
    %----------------------------------------------------------------------
             
        for k=1:length(trialsList)
            
            EMGselectionIndexes{k}=findIndexes(AnalogDataLabels{k},EMGsSelected_C3DLabels);
            EMGsSelected{k}=AnalogRawData{k}(:,EMGselectionIndexes{k});
            EMGsUnits{k}=aUnits{k}(EMGselectionIndexes{k});
        end
        
        %The arrangement of EMG signals in the analog channels may change 
        %among trials, thus EMGselectionIndexes may differ according to the
        %trials used for max computation
        
        for k=1:length(MaxEmgTrialsList)
            
            EMGselectionIndexesForMax{k}=findIndexes(AnalogLabelsForMax{k},EMGsSelected_C3DLabels);
            EMGsSelectedForMax{k}=AnalogRawForMax{k}(:,EMGselectionIndexesForMax{k});
        end
        
        %% ------------------------------------------------------------------------
        %                       EMG FILTERING: ENVELOPE
        %--------------------------------------------------------------------------
        %fcut for EMG assumed fixed (6Hz)
        EMGsEnvelope=EMGFiltering(EMGsSelected,AnalogFrameRate);
        
        EMGsEnvelopeForMax=EMGFiltering(EMGsSelectedForMax,AnalogFrameRate);
        
        %% ------------------------------------------------------------------------
        %                      EMG ANALYSIS WINDOW SELECTION
        %--------------------------------------------------------------------------
        
        [EMGsFiltered,EMGtime]=selectionData(EMGsEnvelope,AnalysisWindow,AnalogFrameRate,EMGOffset);
        
        %if trials for max computation are the same of those for elaboration, max
        %values are computed within the same analysis window, else all signals are
        %considered --> this is not the way!
        %if isequal(MaxEmgTrialsList,trialsList)            
        %    EMGsForMax=selectionData(EMGsEnvelopeForMax,AnalysisWindow,AnalogFrameRate,EMGOffset);
        %else
        %TO DO: implement a way to select a different AnalysisWindow for
        %max EMG computation
        %The analysis window for max identification is the whole trial now:
        EMGsForMax=EMGsEnvelopeForMax; 
        %end

        %% ------------------------------------------------------------------------
        %                        COMPUTE MAX EMG VALUES
        %--------------------------------------------------------------------------
        [MaxEMG_aframes, numMaxEMG_trials,MaxEMGvalues]=computeMaxEMGvalues(EMGsForMax);
        
        disp('Max values for selected emg signals have been computed')        
        sMaxEMG_trials=MaxEmgTrialsList(numMaxEMG_trials);        
        MaxEMG_time=MaxEMG_aframes/AnalogFrameRate;

        %print maxemg.txt
        printMaxEMGvalues(foldersPath.maxemg, EMGsSelected_C3DLabels, MaxEMGvalues, sMaxEMG_trials, MaxEMG_time);
        
        disp('Printed maxemg.txt')
        
        waitbar(6/7);
        
        %% ------------------------------------------------------------------------
        %                            NORMALIZE EMG
        %--------------------------------------------------------------------------
        NormEMG=normalizeEMG(EMGsFiltered,MaxEMGvalues);
        
        %% ------------------------------------------------------------------------
        %                          SAVING and PLOTTING
        %--------------------------------------------------------------------------
       
        if isfield(WindowsSelection,'Offset')            
            EnvelopePlotting(EMGsFiltered,MaxEMGvalues,EMGsSelected_C3DLabels, EMGsUnits, foldersPath.trialOutput, AnalogFrameRate,EMGOffset,WindowsSelection.Offset)
        else
            %Manual method for the Windows Selection has no window offset
            EnvelopePlotting(EMGsFiltered,MaxEMGvalues,EMGsSelected_C3DLabels, EMGsUnits, foldersPath.trialOutput, AnalogFrameRate,EMGOffset)
        end
        
        %storing all info related to max EMGs in a struct
        MaxEMGstruct.values=MaxEMGvalues;
        MaxEMGstruct.muscles=EMGsSelected_C3DLabels;
        MaxEMGstruct.aframes=MaxEMG_aframes;
        MaxEMGstruct.time=MaxEMG_time;
        MaxEMGstruct.trials=numMaxEMG_trials;
        MaxEMGstruct.trialNames=sMaxEMG_trials;
        
        maxEmgPlotting(EMGsSelectedForMax,EMGsForMax,EMGsUnits{1}{1},foldersPath.maxemg,AnalogFrameRate, MaxEMGstruct)
        
        % ------------------------------------------------------------------------
        %                            PRINT emg.txt
        %--------------------------------------------------------------------------
        availableFileFormats=['.txt', ' .sto', ' .mot'];
        
        switch EMGOFileFormat
            
            case '.txt'
                
                for k=1:length(trialsList)
                    
                    printEMGtxt(foldersPath.trialOutput{k},EMGtime{k},NormEMG{k},EMGsSelected_OutputLabels);
                end
                        
            case {'.sto','.mot'}
                
                for k=1:length(trialsList)
                    
                    printEMGmot(foldersPath.trialOutput{k},EMGtime{k},NormEMG{k},EMGsSelected_OutputLabels, EMGOFileFormat);
                end

            %case ...
            %you can add here other file formats
            
            otherwise
                error('ErrorTests:convertTest', ...
                    ['----------------------------------------------------------------\nWARNING: EMG Output File Format not Available!\nChoose among: [' availableFileFormats ']. Please, check it in your elaboration.xml file'])
        end
        
        disp(['Printed emg' EMGOFileFormat])
        
        waitbar(7/7);
        close(h)

        % -------------------------------------------------------------------------
        %                           PLOTTING EMG
        %--------------------------------------------------------------------------
        plotEMGChoice = questdlg('Do you want to plot EMGs Raw', ...
            'Plotting EMGs', ...
            'Yes','No','Yes');
        
        if strcmp(plotEMGChoice,'Yes')
            
            EMGsPlotting(EMGsSelected,EMGsEnvelope,AnalysisWindow,EMGsSelected_C3DLabels,EMGsUnits,foldersPath.trialOutput,AnalogFrameRate)
            disp('Plotted EMGs')
        end
        
    else
        waitbar(6/7);
        disp('Check your data and/or your configuration files: No EMG raw data to be processed')
        waitbar(7/7);
        close(h)
    end
else
        waitbar(6/7);
        disp(' ')
        disp('EMGs not collected')
        waitbar(7/7);
        close(h)
end
%% -------------------------------------------------------------------------

h = msgbox('Data Processing terminated successfully','Done!');
uiwait(h)

save_to_base(1)
% save_to_base() copies all variables in the calling function to the base
% workspace. This makes it possible to examine this function internal
% variables from the Matlab command prompt after the calling function
% terminates. Uncomment the following command if you want to activate it

