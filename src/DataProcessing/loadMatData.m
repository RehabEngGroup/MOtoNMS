function [data, frames] = loadMatData (sessionDataFolder, trialsList, dataType)

    
for k=1: length(trialsList)
    
    trialMatFolder=cell2mat([sessionDataFolder  trialsList(k) '\']);
    
    load([trialMatFolder dataType '.mat']);
    
    eval(['data{k}=double(' dataType '.RawData);']);
    
    eval(['frames{k}.First=' dataType '.FirstFrame;']);
    eval(['frames{k}.Last=' dataType '.LastFrame;']);
    
    %check markers units: if == 'mm' ok, else convert
    if strcmp(dataType,'Markers')
        eval(['data{k} = markersUnitsCheck(' dataType ');' ]);
    end

end