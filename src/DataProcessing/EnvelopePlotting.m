function [] = EnvelopePlotting(envelope,labels,path,emgRate,emgOffset,windowOffset)

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
