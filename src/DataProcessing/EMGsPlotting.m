function [] = EMGsPlotting(data,envelope,window,labels,path,emgRate)
%
%Implemented by Alice Mantoan, April 2013, <alice.mantoan@dei.unipd.it>

w = waitbar(0,'Plotting emg...Please wait!');

for k=1:length(data)
    
    mkdir([path{k} 'EMGs\Raw' ]);
    
    %conversion in microV during plot to have 'copy-on-write' and reduce
    %time
    trialData=data{k};
    
    for i=1:size(trialData,2)
        
        h=figure;
        
        %Raw
        xt=[1/emgRate:1/emgRate:length(data{k}(:,i))/emgRate];
        %xt=[1:length(data{k}(:,i))]/emgRate;
        plot(xt,trialData(:,i)*1000000)
        %plot(trialData(:,i)*1000000)
        %xlabel('Frames')
        xlabel('Time [s]')
        xlim([0 xt(end)])
          
        %Envelope
        hold on
        plot(xt,envelope{k}(:,i)*1000000,'g','LineWidth',2)
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
        ylabel('microV')
        title(labels{i})
        
        %disp(['Plotted ' path{k}  'EMGs\' tag '\' labels{i} '.fig'])
        %print(h,'-dps',[path{k}  'EMGs\' tag '\' labels{i} '.ps'] )
        saveas(h,[path{k}  'EMGs\Raw\' labels{i} '.fig'])
        %saveas(h,[path{k}  'EMGs\' tag '\' labels{i} '.png'])
        close (h)
    end
     
    waitbar(k/length(data));
     
    save([path{k} 'EMGs\Raw\EMGsSelectedRaw.mat'], 'trialData')
end

close(w)