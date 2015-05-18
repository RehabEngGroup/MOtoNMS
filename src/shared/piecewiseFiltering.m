function piecewiseDataFilt= piecewiseFiltering(b, a, order, data)
%Function for piecewise filtering

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

piecewiseDataFilt=data;

if (length(find(isnan(data)==1))>=1)
    
    [allMissingFrames]=MissingFramesCounter(data);
    
    nGaps=size(allMissingFrames,2);

    if nGaps==1
        
        if size([1:allMissingFrames{1}(1)-1],2)>order*3
            
            piecewiseDataFilt(1:allMissingFrames{1}(1)-1) = filtfilt(b, a, double(data(1:allMissingFrames{1}(1)-1)));           
        else
            fprintf(['WARNING!Piecewise Filtering: Marker not filtered within the first interval due to its size (nGaps=1): it must be more than 3 times the filter order.\n'])
            piecewiseDataFilt(1:allMissingFrames{1}(1)-1)=data(1:allMissingFrames{1}(1)-1);
        end
        
        if size([allMissingFrames{1}(end)+1]:size(data,1),2)>order*3
            piecewiseDataFilt(allMissingFrames{1}(end)+1:size(data,1)) = filtfilt(b, a, double(data(allMissingFrames{1}(end)+1:end)));          
        else
            fprintf(['WARNING!Piecewise Filtering: Marker not filtered within the second interval due to its size (nGaps=1): it must be more than 3 times the filter order.\n'])
            piecewiseDataFilt(allMissingFrames{1}(end)+1:size(data,1))=data(allMissingFrames{1}(end)+1:end);
        end
        
    else
        
        for i=1:nGaps %evaluating each gap
                      
            switch i
                
                case 1
                                      
                    if size([1:allMissingFrames{1}(1)-1],2)>order*3                        
                        piecewiseDataFilt(1:allMissingFrames{1}(1)-1) = filtfilt(b, a, double(data(1:allMissingFrames{1}(1)-1)));                       
                    else
                        fprintf(['WARNING!Piecewise Filtering: Marker not filtered within the first interval due to its size (#gap=1): it must be more than 3 times the filter order.\n'])
                        piecewiseDataFilt(1:allMissingFrames{1}(1)-1)=data(1:allMissingFrames{1}(1)-1);
                    end
                    
                    if size([allMissingFrames{1}(end)+1:allMissingFrames{2}(1)-1],2)>order*3
                        piecewiseDataFilt(allMissingFrames{1}(end)+1:allMissingFrames{2}(1)-1) = filtfilt(b, a, double(data(allMissingFrames{1}(end)+1:allMissingFrames{2}(1)-1)));                       
                    else
                        fprintf(['WARNING!Piecewise Filtering: Marker not filtered within the second interval due to its size (#gap=1): it must be more than 3 times the filter order.\n'])
                        piecewiseDataFilt(allMissingFrames{1}(end)+1:allMissingFrames{2}(1)-1)=data(allMissingFrames{1}(end)+1:allMissingFrames{2}(1)-1);
                    end
                    
                case nGaps
                    
                    if size([allMissingFrames{end}(end)+1:size(data,1)],2)>order*3
                        piecewiseDataFilt(allMissingFrames{end}(end)+1:size(data,1)) = filtfilt(b, a, double(data(allMissingFrames{end}(end)+1:end)));                     
                    else
                        fprintf(['WARNING!Piecewise Filtering: Marker not filtered within the last interval due to its size (#gap=nGaps): it must be more than 3 times the filter order.\n'])
                        piecewiseDataFilt(allMissingFrames{end}(end)+1:size(data,1))=data(allMissingFrames{end}(end)+1:end);
                    end
                    
                otherwise % i<nGaps
                    
                    if size([allMissingFrames{i}(end)+1:allMissingFrames{i+1}(1)-1],2)>order*3                       
                        piecewiseDataFilt(allMissingFrames{i}(end)+1:allMissingFrames{i+1}(1)-1) = filtfilt(b, a, double(data(allMissingFrames{i}(end)+1:allMissingFrames{i+1}(1)-1)));                
                    else
                        fprintf(['WARNING!Piecewise Filtering: Marker not filtered due to the size of the ' num2str(i+1) ' interval : it must be more than 3 times the filter order.\n'])
                        piecewiseDataFilt(allMissingFrames{i}(end)+1:allMissingFrames{i+1}(1)-1)=data(allMissingFrames{i}(end)+1:allMissingFrames{i+1}(1)-1);
                    end                  
            end           
        end
    end
end



