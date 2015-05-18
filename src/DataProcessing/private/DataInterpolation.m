function [interpData,note] = DataInterpolation(data,index, maxGapSize)
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

fprintf('Checking missing values in marker trajectories\n');

for k=1: length(data)
    
    interpData{k}=data{k};
    
    [r,c]=size(data{k});  
    xi=1:r;
    x=1:r;
    
    for j=1:c  %markers(3Columns each)

            %if there are NaN values between the first and last frames,
            %interpolation
            if (length(find(isnan(data{k}(index{k}(1,j):index{k}(2,j),j))==1))>=1)  

                [allMissingFrames{k,j}]=MissingFramesCounter(data{k}(index{k}(1,j):index{k}(2,j),j));
                
                nGaps=size(allMissingFrames{k,j},2);
                
                for i=1:nGaps                  
                    OriginalMissingFrames{k,j}{i}=allMissingFrames{k,j}{i}+index{k}(1,j)-1;
                end
                
                if nGaps==1
                    
                    interpolation=pchip(x(index{k}(1,j):index{k}(2,j)),data{k}(index{k}(1,j):index{k}(2,j),j),xi(index{k}(1,j):index{k}(2,j)));
                                
                    interpData{k}(index{k}(1,j):index{k}(2,j),j) = interpolation;
                    
                    markerNote{j}{1}=['Column ' num2str(j) ' has only one gap of ' num2str(size(OriginalMissingFrames{k,j}{1},2)) ' consecutive frames (' num2str(OriginalMissingFrames{k,j}{1}) '): interpolated.'  ];
                    clear interpolation
                    
                else
                                
                    for i=1:nGaps %evaluating each gap
                        
                        sizeCurrentGap=size(allMissingFrames{k,j}{i},2);
                        
                        if sizeCurrentGap < maxGapSize 
                        %current gap is interpolated only if its size is
                        %smaller than maxGapSize
                            
                            switch i
                                
                                case 1

                                    interpolation=pchip(x(index{k}(1,j):OriginalMissingFrames{k,j}{i+1}(1)-1),data{k}(index{k}(1,j):OriginalMissingFrames{k,j}{i+1}(1)-1,j),xi(index{k}(1,j):OriginalMissingFrames{k,j}{i+1}(1)-1));
                                    
                                    interpData{k}(index{k}(1,j):OriginalMissingFrames{k,j}{i+1}(1)-1,j) = interpolation;

                                    clear interpolation
                                   
                                case nGaps

                                    interpolation=pchip(x(OriginalMissingFrames{k,j}{i-1}(end)+1:index{k}(2,j)),data{k}(OriginalMissingFrames{k,j}{i-1}(end)+1:index{k}(2,j),j),xi(OriginalMissingFrames{k,j}{i-1}(end)+1:index{k}(2,j)));
                                    
                                    interpData{k}(OriginalMissingFrames{k,j}{i-1}(end)+1:index{k}(2,j),j) = interpolation;

                                    clear interpolation
                                    
                                otherwise % i<nGaps
                                    
                                    interpolation=pchip(x(OriginalMissingFrames{k,j}{i-1}(end)+1:OriginalMissingFrames{k,j}{i+1}(1)-1),data{k}(OriginalMissingFrames{k,j}{i-1}(end)+1:OriginalMissingFrames{k,j}{i+1}(1)-1,j),xi(OriginalMissingFrames{k,j}{i-1}(end)+1:OriginalMissingFrames{k,j}{i+1}(1)-1));
                                    
                                    interpData{k}(OriginalMissingFrames{k,j}{i-1}(end)+1:OriginalMissingFrames{k,j}{i+1}(1)-1,j) = interpolation;

                                    clear interpolation                                   
                            end
                            
                            markerNote{j}{i}=['Column ' num2str(j) ', gap ' num2str(i)  ' interpoleted for ' num2str(size(OriginalMissingFrames{k,j}{i},2)) ' consecutive frames (' num2str(OriginalMissingFrames{k,j}{i}) ')'  ];
                            
                        else
                            
                            markerNote{j}{i}=['Column ' num2str(j) ', gap ' num2str(i) ' has more than ' num2str(maxGapSize) ' consecutive missing frames between first and last frame in which it appear: no interpolation!If you want to interpolate even this gap, please change the maxGapSizeAllowed in the elaboration.xml file'];
                            fprintf(['WARNING!Trial ' num2str(k) ', Column ' num2str(j) ': no interpolation\n' ])
                            fprintf(['There is a gap with more than ' num2str(maxGapSize) ' consecutive missing frames between first and last frame in which it appear \n'])
                            fprintf(['If you want to interpolate this gap, please change the MaxGapSize value in the elaboration.xml file\n']);
                        end
                        
                    end
                end
                                
            else
                
               %no missing markers: interpData= data 
               markerNote{j}{1}=['Column ' num2str(j) ' has no missing frames between first and last frame in which it appear: no interpolation'];
            end   
    end
    note{k}=markerNote;  

end



