function trialOutputFolders= mkOutputDir(elaborationFolderPath,trialsList)

warning off

for k=1:length(trialsList)
    
    trialOutputFolders{k}=[elaborationFolderPath '\'  trialsList{k} '\'];
    
    mkdir(trialOutputFolders{k})
    
end
