function filtDataFPt1=filteringDataFPtype1(dataFPt1,Rate,fc,dataType)
% Function for filtering data from force platform of type1
% It filters data only in non-zero values
% Output: <1xnTrials> cell, each cell [nFrames x nCoordinates x nFP]

% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2012-2014 Alice Mantoan, Monica Reggiani
%
% MOtoNMS is free software: you can redistribute it and/or modify it under 
% the terms of the GNU General Public License as published by the Free 
% Software Foundation, either version 3 of the License, or (at your option)
% any later version.
%
% Matlab MOtion data elaboration TOolbox for NeuroMusculoSkeletal applications
% is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
% without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
% PARTICULAR PURPOSE.  See the GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along 
% with MOtoNMS.  If not, see <http://www.gnu.org/licenses/>.
%
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

nTrials=length(dataFPt1);

for k=1:nTrials %n trials

    nr=size(dataFPt1{k},1);    
    nc=size(dataFPt1{k},2);    
    nFP=size(dataFPt1{k},3);
    
    filtDataFPt1{k}=zeros(nr,nc,nFP);  

    for j=1:nFP  %n fp
        
        switch dataType
            %find returns an error if we look for the first non zero
            %element in a null vector --> necessary to separate the cases
            case {'Forces', 'COP'} %COPz is null
                firstValueInd{k}(j)=find(dataFPt1{k}(:,1,j),1,'first');
                lastValueInd{k}(j)=find(dataFPt1{k}(:,1,j),1,'last');
                
            case 'Moments' %only Mz has non zero values
                firstValueInd{k}(j)=find(dataFPt1{k}(:,3,j),1,'first');
                lastValueInd{k}(j)=find(dataFPt1{k}(:,3,j),1,'last');
        end
        
        %selection of COP's non-zero values [Nframes x 3]
        isolatedValues=dataFPt1{k}(firstValueInd{k}(j):lastValueInd{k}(j),:,j); 
        
        %filtering of COP's non-zero values [Nframes x 3]
        isolatedFiltValues=DataFiltering(isolatedValues,Rate,fc{k});  
        
        %paste of COP's filtered values in the k-trial cell, with COP
        %original size [nFrames x nCoordinates x nFP]
        %the only non-zero values are the filtered ones
        filtDataFPt1{k}(firstValueInd{k}(j):lastValueInd{k}(j),:,j)= isolatedFiltValues;
            
        clear isolatedValues isolatedFiltValues
    end
end

