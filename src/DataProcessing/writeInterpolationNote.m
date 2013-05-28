function []=writeInterpolationNote(note,path)
% Write interpolation note in FilterData Folder for each trial
% Implemented by Alice Mantoan, March 2013, <alice.mantoan@dei.unipd.it>

    
for k=1:length(note)
    
    %check for FilterData folder: should already exist as created in
    %saveFilteredData.m
    FilteredDataFolderPath=[path{k} 'FilteredData\'];
    
    if exist(FilteredDataFolderPath,'dir') ~= 7
        mkdir(FilteredDataFolderPath);
    end
    
    fid = fopen([FilteredDataFolderPath 'InterpolationNote.txt'], 'wt');
    
    fprintf(fid,'Trial\t');
    fprintf(fid,'%g', k);
    fprintf(fid,'\n\n');
    trialNote=note{k};
    save_to_base(1)
    for j=1:length(trialNote)
        fprintf(fid,trialNote{j});
        fprintf(fid,'\n');
    end
    fprintf(fid,'\n');
    
    fclose(fid);
end

