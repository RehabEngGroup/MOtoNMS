function [] = ResultsVisualComparison(data,filteredData,path,tag)
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

for k=1:length(data)
    
    mkdir([path{k} fullfile('FilteredData','Figures') filesep]);
      
    if length(size(data{k}))>2
        
        for i=1:size(data{k},3)
            h=figure;
            %subplot(size(data{k},3),1,i)
            plot(data{k}(:,:,i))
            hold on
            plot(filteredData{k}(:,:,i),'-.')
            legend('data-x', 'data-y', 'data-z','filtered data-x','filtered data-y','filtered data-z')
            title(tag)
            saveas(h,[path{k} fullfile('FilteredData','Figures','FP') num2str(i) '_' tag '.fig'])
            close (h)
        end

    else
        for i=1:size(data{k},2)
            h=figure;
            plot(data{k}(:,i))
            hold on
            plot(filteredData{k}(:,i),'r')
            legend('data','filtered data')
            saveas(h,[path{k} fullfile('FilteredData','Figures','Trial_') num2str(k) '.png'])
            close (h)
        end
    end
end
    


