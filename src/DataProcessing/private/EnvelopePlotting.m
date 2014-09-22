function [] = EnvelopePlotting(envelope, maxemg, emglabels, units, path,emgRate,emgOffset,windowOffset)
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
if nargin<8 %Manual method for window selection case
    windowOffset=0;   
end

xstring='% Analysis Window';

for k=1:length(envelope)
    
    mkdir([path{k} fullfile('EMGs','Envelope')]);
    
    env=envelope{k};   
    u=units{k};
    
    %Plot each envelope singularly
    for i=1:size(env,2) 

        normenv(:,i) = (env(:,i))./maxemg(i);
        
        x=[1:size(env(emgOffset*emgRate+windowOffset:end-windowOffset,i),1)]/size(env(emgOffset*emgRate+windowOffset:end-windowOffset,i),1)*100;
        
        h=figure;
        set(h, 'Visible', 'off')
        %plot(x,env(emgOffset*emgRate+windowOffset:end-windowOffset,i)*1000000);
        [haxes,H1,H2]=plotyy(x, normenv(emgOffset*emgRate+windowOffset:end-windowOffset,i)*100,x,(env(emgOffset*emgRate+windowOffset:end-windowOffset,i)),'plot');
        
        set(H2,'LineStyle',':')
                     
        xlabel(xstring)
        
        % y1 axis limits
        ylimits(1) = min(normenv(:,i))*100;
        ylimits(2) = max(normenv(:,i))*100;
        set(haxes(1), 'YLim', ylimits);
        
        try
            %y1 ticks
            ytick  = round(linspace(ylimits(1),ylimits(2),4));
            set(haxes(1),'YTick',ytick); 
        catch
            %do nothing: automatic setting of YTick
            disp(['Envelope plot (muscle ' emglabels{i} ', trial ' num2str(k) ': left Y-axis scale automatically set'])
        end
        
        % y2 axis limits
        ylimits2(1) = min(env(:,i));
        ylimits2(2) = max(env(:,i));
        set(haxes(2), 'YLim', ylimits2);
        
        try
            %y2 ticks
            ytick2  = linspace(ylimits2(1),ylimits2(2),4);
            set(haxes(2),'YTick',ytick2);
        catch
            %do nothing: automatic setting of YTick
            disp(['Envelope plot (muscle ' emglabels{i} ', trial ' num2str(k) ': right Y-axis scale automatically set'])
        end
                    
        axes(haxes(2))
        set(haxes(1),'box','off')
        ylabel(['Envelope (' u{i} ')'])
        
        axes(haxes(1))
        set(haxes(2),'hittest','off')         %turn off the HitTestproperty 
        set(haxes(1),'hittest','on')          %on the axis on the right
        ylabel('Normalized Envelope (% max)')
       
        title(emglabels{i})
        
        saveas(h,[path{k}  fullfile('EMGs','Envelope') filesep emglabels{i} '.fig'])
        % saveas(h,[path{k}  'EMGs\' tag '\' emglabels{i} '.png'])
        close(h)        
    end
       
    save([path{k} fullfile('EMGs','Envelope','EMGsSelectedEnvelope.mat')], 'env', 'emglabels')
    save([path{k} fullfile('EMGs','Envelope','emg.mat')], 'normenv', 'emglabels')
    
    %Plot all normalized envelope togheter
    lineStyle={'-', '--', ':', '-.', '+', 'o', '*', '.', 'x', 's', 'd', 'v', '^', '>','<','p','h'};
    color={'b', 'r','g', 'c', 'm','y','k'};
    icolor=1;
    iline=1;
    w=figure;
    hold on
    for i=1:size(normenv,2)

        plot(x, normenv(emgOffset*emgRate+windowOffset:end-windowOffset,i)*100, strcat(lineStyle{iline},color{icolor}))
        
        xlabel(xstring)
        ylabel('Normalized Envelope (% max)')
        ylim([0 100])
        warning off
        legend(emglabels) 
        
        if icolor==size(color,2)
            icolor=1;
            iline=iline+1;
        else
            icolor=icolor+1;
        end
    end 
    
    hold off
    saveas(w,[path{k} fullfile('EMGs','Envelope','AllNormalizedEnvelopes.fig')])
    close(w)
    clear env normenv
end

