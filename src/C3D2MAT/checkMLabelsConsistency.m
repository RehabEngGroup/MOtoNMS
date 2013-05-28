function [] = checkMLabelsConsistency(MLabels,newMLabels)

if (strcmp(MLabels,newMLabels))
    return
else
    disp('Data Inconsistency: MLabels differs among trials')
end

%not saving labels for static trails
    