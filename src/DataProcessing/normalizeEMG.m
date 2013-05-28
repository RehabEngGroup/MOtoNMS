function NormEMG = normalizeEMG(filtEMG,MaxEMGValues)

for k=1:length(filtEMG) %n trials
    for i=1:length(MaxEMGValues)    %n channels
        
        NormEMG{k}(:,i) = (filtEMG{k}(:,i))./MaxEMGValues(i);
    
    end
end
