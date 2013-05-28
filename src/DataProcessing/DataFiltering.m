function filtData = DataFiltering(data,dataRate,fcut)

%Filter parameters
order=2;
FilterType='lp';
dt=1/dataRate;

for k=1: length(data)
    
    if iscell(data)==0 %without cell struct
         filtData = matfiltfilt2(dt, (fcut), order, FilterType, data);
    else
        
        if length(size(data{k}))>2
            for i=1:size(data{k},3)
                filtData{k}(:,:,i) = matfiltfilt2(dt, (fcut{k}), order, FilterType, data{k}(:,:,i));
            end
        else
            %matfiltfilt filters data along columns
            filtData{k} = matfiltfilt2(dt, (fcut{k}), order, FilterType, data{k});
            %what changes among trials is fcut
        end
        %To save forces in a struct with labels:
        %eval(['filtData.' cell2mat(trialsList(k)) '= matfiltfilt2(dt, fcut{k}, order, FilterType, data );']);
    end
end
