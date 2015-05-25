function [] = maxEmgPlotting(emgraw,envelope,unit,path,emgRate, maxEMGinfo)
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

emglabels=maxEMGinfo.muscles;
nEMGs=size(emglabels,2);

for i=1:nEMGs
    
    emgraw_index=maxEMGinfo.trials(i);

    h=figure;
    
    %Raw
    xt=[1/emgRate:1/emgRate:length(emgraw{emgraw_index}(:,i))/emgRate];
    %no unit conversion: plot are in the raw data unit
    plot(xt,emgraw{emgraw_index}(:,i))
    xlabel('Time [s]')
    xlim([0 xt(end)])
    
    %Envelope
    hold on
    plot(xt,envelope{emgraw_index}(:,i),'g','LineWidth',2)
    
    %max emg
    a=axis;
    plot(maxEMGinfo.time(i),maxEMGinfo.values(i),'or','LineWidth',2)
    line([maxEMGinfo.time(i) maxEMGinfo.time(i)],[a(3) a(4)],'Color','r', 'LineStyle','--' )
    
    legend('emg Raw','envelope','max emg')
    ylabel(unit)
    trialName=regexprep(maxEMGinfo.trialNames{i}, '_', ' ');
    title([emglabels{i} ' - ' trialName])
    
    saveas(h,[path filesep emglabels{i} '_' maxEMGinfo.trialNames{i} '.fig'])
    close (h)
end

save([path  filesep 'EMGsRawForMax.mat'], 'emgraw')
save([path  filesep 'EMGsEnvelopeForMax.mat'], 'envelope')
save([path  filesep 'maxemg.mat'], 'maxEMGinfo')


