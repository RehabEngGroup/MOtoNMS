function [] = EnvelopePlotting(envelope,labels,path,emgRate,emgOffset,windowOffset)
%
% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
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
if nargin<6
    windowOffset=0;
end

for k=1:length(envelope)
    
    mkdir([path{k} 'EMGs\Envelope']);
    
    trialData=envelope{k};
    
    for i=1:size(trialData,2)
        
        h=figure;       
            
        x=[1:size(trialData(emgOffset*emgRate+windowOffset:end-windowOffset,i),1)]/size(trialData(emgOffset*emgRate+windowOffset:end-windowOffset,i),1)*100;
        plot(x,trialData(emgOffset*emgRate+windowOffset:end-windowOffset,i)*1000000)
        
        if nargin<6
            xlabel('% Analysis Window')
        else
            xlabel('% Stance')
        end

        legend('Envelope')
        ylabel('microV')
        title(labels{i})
        
        saveas(h,[path{k}  'EMGs\Envelope\' labels{i} '.fig'])            
        % saveas(h,[path{k}  'EMGs\' tag '\' labels{i} '.png'])
        close (h)
    end
       
    save([path{k} 'EMGs\Envelope\EMGsSelectedEnvelope.mat'], 'trialData')
end
