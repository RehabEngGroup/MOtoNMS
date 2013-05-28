function [newMarkersList,newMarkersLabelList]=updatingMarkersList(LJC,RJC,markersList,leftName,rightName,markersLabelList)


%Adding joint center trajectories
newMarkersList=[markersList LJC RJC];

newMarkersLabelList=markersLabelList;

%Updating Markers Label List
newMarkersLabelList{1}(end+1)={leftName};
newMarkersLabelList{1}(end+1)={rightName};

