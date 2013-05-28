function [] = ResultsVisualComparison(data,filteredData,path,tag)


for k=1:length(data)
    
    mkdir([path{k} 'FilteredData\Figures\']);
   
    
    if length(size(data{k}))>2
        
        for i=1:size(data{k},3)
            h=figure;
            %subplot(size(data{k},3),1,i)
            plot(data{k}(:,:,i))
            hold on
            plot(filteredData{k}(:,:,i),'-.')
            legend('data-x', 'data-y', 'data-z','filtered data-x','filtered data-y','filtered data-z')
            title(tag)
            saveas(h,[path{k} 'FilteredData\Figures\FP' num2str(i) '_' tag '.fig'])
            close (h)
        end

    else
        for i=1:size(data{k},2)
            h=figure;
            plot(data{k}(:,i))
            hold on
            plot(filteredData{k}(:,i),'r')
            legend('data','filtered data')
            saveas(h,[path{k} 'FilteredData\Figures\Trial_' num2str(k) '.png'])
            close (h)
        end
    end
end
    


