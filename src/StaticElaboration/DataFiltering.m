function filtData = DataFiltering(data,dataRate,fcut)

%Filter parameters
order=2;
FilterType='lp';
dt=1/dataRate;

for k=1: length(data)

   %matfiltfilt filters data along columns
   filtData{k} = matfiltfilt2(dt, str2num(fcut{k}), order, FilterType, data{k});
   %what changes among trials is fcut
   
    %To save forces in a struct with labels:
    %eval(['filtData.' cell2mat(trialsList(k)) '= matfiltfilt2(dt, fcut{k}, order, FilterType, data );']);
     
end
