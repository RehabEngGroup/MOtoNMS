function [] = EMGsPlotting(data,envelope,window,emglabels,units,path,emgRate)
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

w = waitbar(0,'Plotting emg...Please wait!');

for k=1:length(data)
    
    mkdir([path{k} fullfile('EMGs','Raw')]);
    
    %conversion in microV during plot to have 'copy-on-write' and reduce
    %time
    emgraw=data{k};
    u=units{k};
    
    for i=1:size(emgraw,2)
        
        h=figure;
        
        %Raw
        xt=[1/emgRate:1/emgRate:length(data{k}(:,i))/emgRate];
        %xt=[1:length(data{k}(:,i))]/emgRate;
        %no unit conversion: plot are in the raw data unit
        plot(xt,emgraw(:,i)) 
        %plot(emgraw(:,i)*1000000)
        %xlabel('Frames')
        xlabel('Time [s]')
        xlim([0 xt(end)])
          
        %Envelope
        hold on
        plot(xt,envelope{k}(:,i),'g','LineWidth',2)
        %plot(xt,envelope{k}(:,i)*1000000,'g','LineWidth',2)
        %legend(['emg Raw','envelope'])
        
        %Window
        a=axis; %return xlim ylim
        %startFrame=(window{k}.startFrame*emgRate)/window{k}.rate;
        %endFrame=(window{k}.endFrame*emgRate)/window{k}.rate;     
        startTime=[(window{k}.startFrame*emgRate)/window{k}.rate]/emgRate;
        endTime=[(window{k}.endFrame*emgRate)/window{k}.rate]/emgRate;
        
        hold on
        %line([startFrame startFrame],[a(3) a(4)],'Color','r' )
        %line([endFrame endFrame],[a(3) a(4)],'Color','r' )      
        line([startTime startTime],[a(3) a(4)],'Color','r' )
        line([endTime endTime],[a(3) a(4)],'Color','r' )
        
        legend('emg Raw','envelope','window') 
        ylabel(u{i})
        title(emglabels{i})
        
        %disp(['Plotted ' path{k}  'EMGs\' tag '\' emglabels{i} '.fig'])
        %print(h,'-dps',[path{k}  'EMGs\' tag '\' emglabels{i} '.ps'] )
        saveas(h,[path{k}  fullfile('EMGs','Raw') filesep emglabels{i} '.fig'])
        %saveas(h,[path{k}  'EMGs\' tag '\' emglabels{i} '.png'])
        close (h)
    end
     
    waitbar(k/length(data));
     
    save([path{k}  fullfile('EMGs','Raw','EMGsSelectedRaw.mat')], 'emgraw', 'emglabels')
end

close(w)
