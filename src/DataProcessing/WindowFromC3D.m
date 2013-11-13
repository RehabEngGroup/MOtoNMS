function WindowC3D = WindowFromC3D(WindowsSelectionInfo, DataOffset, Rates)

for k=1:length(WindowsSelectionInfo.Events)
       
    eventFrames=[];

    for j=1: size(WindowsSelectionInfo.Events{k},2) %n di trials
        
        %consider only events which correspond to the choosen leg
        if (strcmp(WindowsSelectionInfo.Leg, WindowsSelectionInfo.Events{k}(j).context))
            
            %check labels
            if (strcmp(WindowsSelectionInfo.Events{k}(j).label,WindowsSelectionInfo.Labels.Start) || strcmp(WindowsSelectionInfo.Events{k}(j).label, WindowsSelectionInfo.Labels.Stop))
                
                eventFrames=[eventFrames WindowsSelectionInfo.Events{k}(j).frame];
            end       
        end
    end
    
    if isempty(eventFrames)
        error('Events in the c3d file do not correspond to the assigned labels.')
        
    else if length(eventFrames)>2
            
            error('More than 2 events with the assigned labels in the c3d file')
            
        else if length(eventFrames)<2
                error('Less than 2 events in the c3d file')               
            else
                [eord,ind]=sort(eventFrames);
                
                WindowC3D{k}.startFrame=eord(1)-DataOffset{k};
                WindowC3D{k}.endFrame=eord(2)-DataOffset{k};
                WindowC3D{k}.rate=Rates.VideoFrameRate;
                
            end
        end
    end
end
