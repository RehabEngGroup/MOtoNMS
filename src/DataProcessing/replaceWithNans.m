function [newData,index] = replaceWithNans(data)
%This function replaces missing markers value (=0) in data with NaN
%If markers trajectories start with 0, index of first and last frame in
%which markers appear are saved

for k=1:length(data)
    
    markers=data{k};
    
    newMarkers = markers;
    
    [m, n] = size(markers);
        
    for j = 1:n

        if markers(1,j)==0  %if markers are not visible from the beginning
            index{k}(1,j)=find(markers(:,j), 1, 'first');
            index{k}(2,j)=find(markers(:,j), 1, 'last');
            %looking for the first and last frame in which each marker is
            %visible
        else
%           index{k}(1,j)=1;
%           index{k}(2,j)=m;
            index{k}(1,j)=0;
            index{k}(2,j)=0;            
        end
        
        for i = 1:m
            %replace each 0 with NaN
            if markers(i,j)== 0
                newMarkers(i,j) = NaN;
            end
        end
    end

    newData{k}=newMarkers;
    
    clear markers newmarkers
end




% function [newData,index] = replaceWithNans(data)
% %This function replaces missing markers value (=0) in data with NaN
% %If markers trajectories start with 0, index of first and last frame in
% %which markers appear are saved
% 
% for k=1:length(data)
%     
%     markers=data{k};
%     
%     newMarkers = markers;
%     
%     [m, n] = size(markers);
%         
%     for j = 1:n
%         
%         if markers(1,j)==0  %if markers are not visible from the beginning
%             index{j}(1,1)=find(markers(:,j), 1, 'first');
%             index{j}(1,2)=find(markers(:,j), 1, 'last');
%             %looking for the first and last frame in which each marker is
%             %visible
%         else
%             index{j}=[];
%         end
%         
%         for i = 1:m
%             %replace each 0 with NaN
%             if markers(i,j)== 0
%                 newMarkers(i,j) = NaN;
%             end
%         end
%     end
% 
%     newData{k}=newMarkers;
%     
%     clear markers newmarkers
%     
% end

