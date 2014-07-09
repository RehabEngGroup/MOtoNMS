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
            %and manage the case a force platform has all 0 values
            case {'Forces', 'COP'} %COPz is null
                try
                    firstValueInd{k}(j)=find(dataFPt1{k}(:,1,j),1,'first');
                    lastValueInd{k}(j)=find(dataFPt1{k}(:,1,j),1,'last');
                    findValues=1;
                    
                catch
                    findValues=0; %FP data are all null(a FP not struck or not working)
                end
                
            case 'Moments' %only Mz has non zero values
                try
                    firstValueInd{k}(j)=find(dataFPt1{k}(:,3,j),1,'first');
                    lastValueInd{k}(j)=find(dataFPt1{k}(:,3,j),1,'last');
                    findValues=1;
                catch
                    findValues=0;                   
                end
        end
        
        if findValues
            %selection of COP's non-zero values [Nframes x 3]
            isolatedValues=dataFPt1{k}(firstValueInd{k}(j):lastValueInd{k}(j),:,j);
            
            %filtering of COP's non-zero values [Nframes x 3]
            isolatedFiltValues=DataFiltering(isolatedValues,Rate,fc{k});
            
            %paste of COP's filtered values in the k-trial cell, with COP
            %original size [nFrames x nCoordinates x nFP]
            %the only non-zero values are the filtered ones
            filtDataFPt1{k}(firstValueInd{k}(j):lastValueInd{k}(j),:,j)= isolatedFiltValues;
            
            clear isolatedValues isolatedFiltValues
        end %else dataFPt1{k}(:,:,j) is null and filtDataFPt1 was already set to 0
    end
end

