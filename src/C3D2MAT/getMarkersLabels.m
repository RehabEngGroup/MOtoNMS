function [MLabels] = getMarkersLabels(itf)   


indexLabels = itf.GetParameterIndex('POINT','LABELS');

nItems = itf.GetParameterLength(indexLabels);

nIndex2 = itf.GetParameterIndex('POINT', 'LABELS2');
nIndex3 = itf.GetParameterIndex('POINT', 'LABELS3');

if nIndex2 ~= -1;
    nItems2 = itf.GetParameterLength(nIndex2);
end

if nIndex3 ~= -1;
    nItems3 = itf.GetParameterLength(nIndex3);
end


nChannels = itf.GetParameterDimension(indexLabels,1);

for i=1:(nChannels)
    MLabels{i} = itf.GetParameterValue(itf.GetParameterIndex('POINT','LABELS'),(i-1));
    
end

j=i+1;
if nIndex2 ~= -1
    for i = 1 : nItems2-1,
        target_name = itf.GetParameterValue(nIndex2, i-1);
        MLabels{j}=target_name ;
        j=j+1;
    end
end

k=j+1;
if nIndex3 ~= -1
    for i = 1 : nItems3-1,
        
         target_name = itf.GetParameterValue(nIndex3, i-1);
         MLabels{k}=target_name ;
         k=k+1;
    end
end

