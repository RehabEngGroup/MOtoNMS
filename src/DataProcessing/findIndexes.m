function indexes=findIndexes(InitialList,list)

indexes=[];

for i=1: length(list)
    
    item=list(i);
    
    for j=1:length(InitialList)
        
        if strcmp(item,InitialList(j))
            indexes=[indexes j];
        end
    end
end
