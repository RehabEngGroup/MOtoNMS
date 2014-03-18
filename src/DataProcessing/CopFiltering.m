function filteredCOP=CopFiltering(COP,Rate,fc)
% Function for COP filtering
% It filters COP only in non-zero values
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

nTrials=length(COP);

for k=1:nTrials %n trials

    nr=size(COP{k},1);    
    nc=size(COP{k},2);    
    nFP=size(COP{k},3);
    
    filteredCOP{k}=zeros(nr,nc,nFP);  
    
    for j=1:nFP  %n fp
        
        firstValueInd{k}(j)=find(COP{k}(:,1,j),1,'first');
        lastValueInd{k}(j)=find(COP{k}(:,1,j),1,'last');
        
        %selection of COP's non-zero values [Nframes x 3]
        isolatedCOP=COP{k}(firstValueInd{k}(j):lastValueInd{k}(j),:,j); 
        
        %filtering of COP's non-zero values [Nframes x 3]
        isolatedCOPfilt=DataFiltering(isolatedCOP,Rate,fc{k});  
        
        %paste of COP's filtered values in the k-trial cell, with COP
        %original size [nFrames x nCoordinates x nFP]
        %the only non-zero values are the filtered ones
        filteredCOP{k}(firstValueInd{k}(j):lastValueInd{k}(j),:,j)= isolatedCOPfilt;
            
        clear isolatedCOP isolatedCOPfilt
    end
end







