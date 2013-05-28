function [] = saveMat(Markers, EMG, Forces, Events, trialMatFolder)

save([trialMatFolder 'Markers.mat'], 'Markers')
save([trialMatFolder 'EMG.mat'], 'EMG')
save([trialMatFolder 'Forces.mat'], 'Forces')

%save events only if they are present in the c3d file
if isempty(Events)==0
    save([trialMatFolder 'Events.mat'], 'Events')
end
