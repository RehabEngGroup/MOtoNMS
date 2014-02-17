function [newData,index] = replaceWithNans(data)
%This function replaces missing markers value (=0) in data with NaN
%If markers trajectories start with 0, index of first and last frame in
%which markers appear are saved

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

        if markers(1,j)==0  %if markers are not visible from the beginning
            index{k}(1,j)=find(markers(:,j), 1, 'first');
            index{k}(2,j)=find(markers(:,j), 1, 'last');
            %looking for the first and last frame in which each marker is
            %visible
        else
%           index{k}(1,j)=1;
%           index{k}(2,j)=m;
            index{k}(1,j)=0;
            index{k}(2,j)=0;            
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




% function [newData,index] = replaceWithNans(data)
% %This function replaces missing markers value (=0) in data with NaN
% %If markers trajectories start with 0, index of first and last frame in
% %which markers appear are saved
% 
% for k=1:length(data)
%     
%     markers=data{k};
%     
%     newMarkers = markers;
%     
%     [m, n] = size(markers);
%         
%     for j = 1:n
%         
%         if markers(1,j)==0  %if markers are not visible from the beginning
%             index{j}(1,1)=find(markers(:,j), 1, 'first');
%             index{j}(1,2)=find(markers(:,j), 1, 'last');
%             %looking for the first and last frame in which each marker is
%             %visible
%         else
%             index{j}=[];
%         end
%         
%         for i = 1:m
%             %replace each 0 with NaN
%             if markers(i,j)== 0
%                 newMarkers(i,j) = NaN;
%             end
%         end
%     end
% 
%     newData{k}=newMarkers;
%     
%     clear markers newmarkers
%     
% end

