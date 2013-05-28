function AnalysisWindow =AnalysisWindowSelection(WindowsSelectionInfo,StancesOnFP,Forces,Rates)
% Return Analysis Window according to the selected method
% Implemented by Alice Mantoan, Febraury 2012, <alice.mantoan@dei.unipd.it>

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

        AnalysisWindow=StanceOnFPfromC3D(Forces,platesList,WindowsSelectionInfo, Rates);
        
        WindowOffset=WindowsSelectionInfo.Offset;
        
        if WindowOffset ~= 0
            AnalysisWindow=WindowShift(AnalysisWindow,WindowOffset);
        end

    case 'WindowFromC3D'
        %To choose events outside force platform 
        AnalysisWindow=WindowFromC3D(WindowsSelectionInfo, Rates);
              
        
    case 'Manual'
        
        for k=1:length(Forces)
            AnalysisWindow{k}.startFrame=WindowsSelectionInfo.Events{k}(1);
            AnalysisWindow{k}.endFrame=WindowsSelectionInfo.Events{k}(2);
            AnalysisWindow{k}.rate=Rates.VideoFrameRate;
        end
            
end


