function [newData] = correctBordersAfterFiltering(data,oldData,index)
%
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
borderSize=3;

for k=1:length(data)
    
    markers=data{k};
    oldmarkers=oldData{k};
    
    newMarkers = markers;
    
    [m, n] = size(markers);
        
    for j = 1:n
        
      if index{k}(:,j)~= 0
         newMarkers(1:index{k}(1,j)-1,j)=0;
         
         newMarkers(index{k}(1,j):index{k}(1,j)+borderSize,j)=oldmarkers(index{k}(1,j):index{k}(1,j)+borderSize,j); %values near borders are set to the original 
         
         newMarkers(index{k}(2,j)+1:end,j)=0;
         newMarkers(index{k}(2,j)-borderSize:index{k}(2,j),j)=oldmarkers(index{k}(2,j)-borderSize:index{k}(2,j),j);
      end
    end

    newData{k}=newMarkers;
    
    clear markers newmarkers
    
end