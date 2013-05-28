function []=saveAnalysisWindow(path, window)

for k=1:length(window)
    
    FolderPath=[path{k} 'FilteredData\'];
   
    if exist(FolderPath,'dir') ~= 7
        mkdir(FolderPath);
    end
    
    AnalysisWindow=window{k};
    
    save([FolderPath 'AnalysisWindow.mat'], 'AnalysisWindow')

end