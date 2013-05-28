function [] = printMaxEMGvalues(dirPath, EMGLabels, MaxEMGvalues)

nEMGChannels=length(EMGLabels);

fid = fopen([dirPath, '\maxemg.txt'], 'w');

for i=1:nEMGChannels
    MaxEMGLabel = [char(EMGLabels{i}),'_max '];
    fprintf(fid,'%s%6.6f\n', char(MaxEMGLabel), MaxEMGvalues(i));
end

fclose(fid);

save([dirPath '\maxemg.mat'],'MaxEMGvalues')
