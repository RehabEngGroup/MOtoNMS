function events = loadEvents (path,trialsList)

for k=1: length(trialsList)
    
    trialMatFolder=cell2mat([path  trialsList(k) '\']);
    
    load([trialMatFolder 'Events.mat']);
    
    events{k}=Events;
    
    clear Events
end