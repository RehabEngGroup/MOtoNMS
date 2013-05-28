function StanceFPc3d = StanceOnFPfromC3D(Forces, platesList, WindowsSelectionInfo, Rates)


for k=1:length(Forces)
    
    Fz=Forces{k}(:,3,platesList{k});
    
    eventsFrame=[];
    
    for j=1: size(WindowsSelectionInfo.Events{k},2)
        
        %consider only events which correspond to the choosen leg
        if (strmatch(WindowsSelectionInfo.Leg, WindowsSelectionInfo.Events{k}(j).context))
            
            frame=(WindowsSelectionInfo.Events{k}(j).frame/Rates.VideoFrameRate)*Rates.AnalogFrameRate;
            
            if Fz(frame)<-20
                eventsFrame=[eventsFrame WindowsSelectionInfo.Events{k}(j).frame];
                
                %check it is really a heel strike or toe off
                if (strmatch(WindowsSelectionInfo.Events{k}(j).label, WindowsSelectionInfo.Labels.HS))
                    hsFrame=WindowsSelectionInfo.Events{k}(j).frame;
                else if (strmatch(WindowsSelectionInfo.Events{k}(j).label, WindowsSelectionInfo.Labels.FO))
                        foFrame=WindowsSelectionInfo.Events{k}(j).frame;
                    else
                        error('Events do not correspond to the given labels for heel strike and foot off')
                    end
                end
                    
            end 
        end
    end

    if exist('frame','var')==0
        error('Events in .c3d files do not correspond to the choosen leg: change analysis window method ')
        
    else if (exist('eventsFrame','var') && length(eventsFrame)<2)
            error('Events in the c3d file do not correspond to force data: Unable to compute stance on force plates. Check events (modifications to c3d files require to rerun C3D2MAT!)or change analysis window method.')
            
        else
            StanceFPc3d{k}.startFrame=hsFrame;
            StanceFPc3d{k}.endFrame=foFrame;
            StanceFPc3d{k}.rate=Rates.VideoFrameRate;
            
        end
    end
end
          