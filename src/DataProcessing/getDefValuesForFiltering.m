function defValues= getDefValuesForFiltering(newTypeList, oldTypeList, oldValues)

for i=1:length(newTypeList)
    
    ind=find(strcmp(oldTypeList,newTypeList{i}));
    
    if isempty(ind)==0
        defValues{i}=num2str(oldValues{ind});
    else
        defValues{i}=' ';
    end
end
