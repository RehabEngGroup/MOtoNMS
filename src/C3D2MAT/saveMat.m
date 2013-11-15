function [] = saveMat(Markers, AnalogData, FPdata, Events, trialMatFolder)

save([trialMatFolder 'Markers.mat'], 'Markers')
save([trialMatFolder 'AnalogData.mat'], 'AnalogData')
save([trialMatFolder 'FPdata.mat'], 'FPdata')

%save events only if they are present in the c3d file
if isempty(Events)==0
    save([trialMatFolder 'Events.mat'], 'Events')
end
