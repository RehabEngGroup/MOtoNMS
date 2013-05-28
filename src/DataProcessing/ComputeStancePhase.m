function StancePhase = ComputeStancePhase(filtForces,platesList,FzThreshold,Rates)
% Method to compute start and end frame of the Analysis Window.
% It selects stance phase within gait cycle:
% start == heel strike
% end == toe off
% if you need more than a stance another method should be used.

% VideoFrameRate is needed to select a startFrame which correspond to a
% time instant sample in the lowest frame rate, otherwise  markers and
% forces may not be perfectly synchronized:with force frame rate there might
% be time samples which do not have an exact correspondence in video frame
% rate
% Implemented by Alice Mantoan, August 2012, <alice.mantoan@dei.unipd.it>
%--------------------------------------------------------------------------

VideoFrameRate=Rates.VideoFrameRate;
AnalogFrameRate=Rates.AnalogFrameRate;

for k=1:length(filtForces)
    
    FPused=platesList{k};
    
    if length(FPused)==1
        
        Fz=filtForces{k}(:,3,FPused);
        
        a = find(-Fz > FzThreshold);   %a(1) == heel strike in force rate
                                       %a(end) == toe off in force rate       
    else
        
        disp(['Wrong input platform data for trial' num2str(k) 'in the list: a stance should be computed from just one force platform data'])
        disp('If you want more, change Analysis window computation method')
        
        return
    end
    %conversion in video frame rate
    StancePhase{k}.startFrame=round(a(1)*(VideoFrameRate/AnalogFrameRate));
    StancePhase{k}.endFrame=round(a(end)*(VideoFrameRate/AnalogFrameRate)) ;
    StancePhase{k}.rate=VideoFrameRate;
    %rate store for each trial even if it is the same for all
    
    clear a    
end
   

