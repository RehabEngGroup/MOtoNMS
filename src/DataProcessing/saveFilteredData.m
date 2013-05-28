function []=saveFilteredData(path, time, data, dataType)

for k=1:length(data)
 
    FilteredDataFolderPath=[path{k} 'FilteredData\'];
  
    if exist(FilteredDataFolderPath,'dir') ~= 7
        mkdir(FilteredDataFolderPath);
    end

    save([FilteredDataFolderPath 'filteredSelected' dataType '.mat'], 'time', 'data')

end