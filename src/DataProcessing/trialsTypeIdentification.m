function trialsTypeList = trialsTypeIdentification(trialsList)
%trialsList should be a cell
%It assumes that each trial name is composed by trial type+repetition num
%Implemented by Alice Mantoan, February 2013, <alice.mantoan@dei.unipd.it>

j=1;
trialsTypeList{j}='';

for k=1:length(trialsList)
    
    trialType=getTrialType(trialsList{k});
    
    if k==1
        trialsTypeList{1}=trialType;
        j=j+1;
    else
        if strcmp(trialsTypeList{j-1},trialType)==0
            
            trialsTypeList{j}=trialType;
            j=j+1;           
        end
    end
end

