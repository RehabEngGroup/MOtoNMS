function singleData= fromTypeToSingle(list, typeList, typeData)
%Function necessary to extend filtering parameters from trial type to each
%single trial
%Implemented by Alice Mantoan, February 2013, <alice.mantoan@dei.unipd.it>

for i=1:length(list)
    
    trialType = getTrialType(list{i});
    
    for j=1:length(typeList)
        
        if strcmp(trialType,typeList{j})
            trialTypeIndex=j;
        end
    end
    
    singleData{i}=typeData{trialTypeIndex};
end


