function [newData] = correctBordersAfterFiltering(data,oldData,index)

for k=1:length(data)
    
    markers=data{k};
    oldmarkers=oldData{k};
    
    newMarkers = markers;
    
    [m, n] = size(markers);
        
    for j = 1:n
        
      if index{k}(:,j)~= 0
         newMarkers(1:index{k}(1,j)-1,j)=0;
         
         newMarkers(index{k}(1,j):index{k}(1,j)+7,j)=oldmarkers(index{k}(1,j):index{k}(1,j)+7,j); %values near borders are set to the original 
         
         newMarkers(index{k}(2,j)+1:end,j)=0;
         newMarkers(index{k}(2,j)-7:index{k}(2,j),j)=oldmarkers(index{k}(2,j)-7:index{k}(2,j),j);
      end
    end

    newData{k}=newMarkers;
    
    clear markers newmarkers
    
end