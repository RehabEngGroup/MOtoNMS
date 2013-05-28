function markerstrc = selectingMarkers(MarkersList,MLabels,markers)
%MarkersList: list of markers to print in the trc file
%MLabels: list of markers in the c3d file
%markers: struct of markers trajectories [nFrames x nMarkers*(XYZ)], where
%nMarkers corrisponds to the initial MLabels

for i=1:length(MarkersList)
    j=MarkersList(i);
    z=strmatch(j,MLabels,'exact');
    if i==1
        indexMarkerLabels=[z];
    else
        indexMarkerLabels=[indexMarkerLabels;z];
    end
end

newMarkerLabels=[MLabels(indexMarkerLabels)];
markerstrc=[];

for i=1: length(newMarkerLabels)
    
    newindex=(indexMarkerLabels(i)-1)*3+1;
    markerstrc=[markerstrc markers(:,newindex:newindex+2)];
end


%Other way 
% for i=1:length(MList)
%     for k=1:length(MLabels)
%         v(k)=strcmp(MList{i},MLabels{k})==1
%         
%     end
%     a(i)=find(v==1)
% end

