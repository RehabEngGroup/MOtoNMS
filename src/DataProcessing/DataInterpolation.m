function [interpData,note] = DataInterpolation(data,index,fr)
%Data interpolation
%index for piecewise interpolation
%Interpolation only if there are NaN in the trajectories and only between
%first and last frame in which markers appear.
%If markers are not visible at the beginning and/or the end, 0 value is preserved
%Interpolation is done from first and last frame contained in index array
%and only for a number of consecutive frames less then missingCounter_max

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
%can be manually changed: we interpolate for a maximum of 15 frames
%(assuming a frame rate of 60 Hz), otherwise NaN values are kept
missingCounter_max=(15/60)*fr;
%Here it is possibile to decide the length of the interpolation: we can
%interpolate and dont care for how many frames a marker is missing, or we 
%can check and interpolate only if it is missing for few fixed frames
%(depending on the video frame rate)

for k=1: length(data)
    
    interpData{k}=data{k};
    
    [r,c]=size(data{k});  
    xi=1:r;
    x=1:r;
    
    for j=1:c  %markers(3Columns each)

            %If there was Nan at the beggining or the end, they were re-set 
            %to 0. It was necessary when filtering the whole marker trj.
            %Now DataFiltering is changed: we filter only in the interval
            %in which the marker is visible
%           interpData{k}(1:index{k}(1,j)-1,j)=0;  
%           interpData{k}(index{k}(2,j)+1:end,j)=0;

            if (length(find(isnan(data{k}(index{k}(1,j):index{k}(2,j),j))==1))>=1)
                            
                [allMissingFrames{k,j}, counterMissing{k}(j)]=MissingFramesCounter(data{k}(index{k}(1,j):index{k}(2,j),j));
                
                OriginalMissingFrames{k,j}=allMissingFrames{k,j}+index{k}(1,j)-1;

                if counterMissing{k}(j)<=missingCounter_max
                    
                    interpolation=pchip(x(index{k}(1,j):index{k}(2,j)),data{k}(index{k}(1,j):index{k}(2,j),j),xi(index{k}(1,j):index{k}(2,j)));
                    %interpolation=interp1(x(index{k}(1,j):index{k}(2,j)),data{k}(index{k}(1,j):index{k}(2,j),j),xi(index{k}(1,j):index{k}(2,j)),'spline');
                    interpData{k}(index{k}(1,j):index{k}(2,j),j) = interpolation;
                    %markerNote{j}=['Marker ' num2str(j) ' has been interpolated between first and last frame in which it appear (if there were less than 10 frames missing)'];
                    markerNote{j}=['Column ' num2str(j) ' has been interpolated between first and last frame in which it appear for a maximun of ' num2str(counterMissing{k}(j)) ' consecutive frames (' num2str(OriginalMissingFrames{k,j}) ')' ];
                else
                    %interpData{k}(index{k}(1,j):index{k}(2,j),j)=data{k}(index{k}(1,j):index{k}(2,j),j); not necessary
                    markerNote{j}=['Column ' num2str(j) ' has more than ' num2str(missingCounter_max) ' consecutive missing frames between first and last frame in which it appear: no interpolation'];
                end
                
            else
                
               %no missing markers: interpData= Data (or missing for more than 10 frames)
               %interpData{k}(index{k}(1,j):index{k}(2,j),j)=data{k}(index{k}(1,j):index{k}(2,j),j);
               %not necessary: at the begininng we did interpData=data
               markerNote{j}=['Column ' num2str(j) ' not missing frames between first and last frame in which it appear: no interpolation'];
            end
            
    clear interpolation     
    end
    note{k}=markerNote;
end


