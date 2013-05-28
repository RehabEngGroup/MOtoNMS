function filteredCOP=CopFiltering(COP,Rate,fc)
% Function for COP filtering
% It filters COP only in non-zero values
% Implemented by Alice Mantoan, March 2013, <alice.mantoan@dei.unipd.it>
%--------------------------------------------------------------------------

nTrials=length(COP);

for k=1:nTrials %n trials

    nr=size(COP{k},1);    
    nc=size(COP{k},2);    
    nFP=size(COP{k},3);
    
    filteredCOP{k}=zeros(nr,nc,nFP);
    
    for j=1:nFP  %n fp
        
        firstValueInd{k}(j)=find(COP{k}(:,1,j),1,'first');
        lastValueInd{k}(j)=find(COP{k}(:,1,j),1,'last');
        
        isolatedCOP{k}(1:(lastValueInd{k}(j)-firstValueInd{k}(j))+1,:,j)=COP{k}(firstValueInd{k}(j):lastValueInd{k}(j),:,j);
 
    end
end

filtCOP=DataFiltering(isolatedCOP,Rate,fc);

for k=1:nTrials
    for j=1:nFP
        filteredCOP{k}(firstValueInd{k}(j):lastValueInd{k}(j),:,j)= filtCOP{k}(1:(lastValueInd{k}(j)-firstValueInd{k}(j))+1,:,j);
    end
end






