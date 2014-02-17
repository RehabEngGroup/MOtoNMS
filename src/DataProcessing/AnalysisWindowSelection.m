function AnalysisWindow =AnalysisWindowSelection(WindowsSelectionInfo,StancesOnFP,Forces,Frames,Rates)
% Return Analysis Window according to the selected method

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
for k=1:length(Forces)

    if Frames{k}.First==1
        LabeledDataOffset{k}=0;
    else
        LabeledDataOffset{k}=Frames{k}.First-1;
    end
end

switch WindowsSelectionInfo.Method
    
    case 'ComputeStancePhase'
        
        FzThreshold=40; %abs value, the same for each trial 
        %from literature should be 10 (O'Connor C et al 2007, Automatic 
        %detection of gait events using kinematic data), but after testing
        %for us 40 is a good compromise for different force filtering fcut, 
        %types of movement, force plates. 10 or 20 are too low and after 
        %filtering, they give an higher error in the estimation of contact
        %frame, needed also for cop estimation (the same threshold is set 
        %for COP computation)
        
        platesList=setForcePlateList(StancesOnFP,WindowsSelectionInfo.Leg);
        
        AnalysisWindow=ComputeStancePhase(Forces,platesList,FzThreshold, Rates);
        
        WindowOffset=WindowsSelectionInfo.Offset;
        
        if WindowOffset ~= 0
            AnalysisWindow=WindowShift(AnalysisWindow,WindowOffset);
        end
        
    case 'StanceOnFPfromC3D'
        
        %Events in c3d file may be more than the ones we want
        %Necessary to look at forces to choose the events corresponding to
        %fp
        
        platesList=setForcePlateList(StancesOnFP,WindowsSelectionInfo.Leg);

        AnalysisWindow=StanceOnFPfromC3D(Forces,platesList,WindowsSelectionInfo,LabeledDataOffset,Rates);
        
        WindowOffset=WindowsSelectionInfo.Offset;
        
        if WindowOffset ~= 0
            AnalysisWindow=WindowShift(AnalysisWindow,WindowOffset);
        end

    case 'WindowFromC3D'
        %To choose events outside force platform 
        AnalysisWindow=WindowFromC3D(WindowsSelectionInfo, LabeledDataOffset, Rates);
        
        WindowOffset=WindowsSelectionInfo.Offset;
        
        if WindowOffset ~= 0
            AnalysisWindow=WindowShift(AnalysisWindow,WindowOffset);
        end
              
        
    case 'Manual'
        
        for k=1:length(Forces)
            AnalysisWindow{k}.startFrame=WindowsSelectionInfo.Events{k}(1)-LabeledDataOffset{k};
            AnalysisWindow{k}.endFrame=WindowsSelectionInfo.Events{k}(2)-LabeledDataOffset{k};
            AnalysisWindow{k}.rate=Rates.VideoFrameRate;
        end
            
end

%Necessary to store the LabeledDataOffset for each trial to compute the 
%time vector in selectionData.m
for k=1:length(Forces)
    AnalysisWindow{k}.LabeledDataOffset=LabeledDataOffset{k};
end


