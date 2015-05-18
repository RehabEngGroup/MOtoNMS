function [newData,index] = replaceMissingWithNaNs(data)
%This function replaces missing markers value (=0) in data with NaN
%If markers trajectories are not visible from the beginning and/or till the 
%end, index of first and last frames in which markers appear are saved,
%otherwise index are set to 1 and the last frame for each marker

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

for k=1:length(data)
    
    markers=data{k};
    
    newMarkers = markers;
    
    [m, n] = size(markers);
        
    for j = 1:n
        %looking for the first and last frame in which each marker is
        %visible
        
        if ((markers(1,j)==0 || isnan(markers(1,j))) && nargout==2)
        %if markers are not visible from the beginning (being 0 or NaN, 
        %according to the acquisition system) & if index is required in output
        
        %find returns an error if the vector has all 0 values
        %It may happen when index is not required, that is in the second
        %call of this function within runDataProcessing
            tmp=find(isnan(markers(:,j))==0 & markers(:,j)~=0);
            index{k}(1,j)=tmp(1); %keep the first element
     
        else
            index{k}(1,j)=1;
        end
        
        if ((markers(end,j)==0 || isnan(markers(end,j))) && nargout==2)
        %if markers are not visible till the end & if index is required in output
            tmp=find(isnan(markers(:,j))==0 & markers(:,j)~=0);
            index{k}(2,j)=tmp(end); %keep the last element
        else
            index{k}(2,j)=m; %the last frame
        end
                      
        for i = 1:m
            %replace each 0 with NaN
            if markers(i,j)== 0
                newMarkers(i,j) = NaN;
            end
        end
    end

    newData{k}=newMarkers;
    
    clear markers newmarkers
end

