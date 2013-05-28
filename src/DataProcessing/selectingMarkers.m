function markerstrc = selectingMarkers(MarkersList,MLabels,markers)
%MarkersList: list of markers to print in the trc file
%MLabels: list of markers in the c3d file
%markers: struct of markers trajectories [nFrames x nMarkers*(XYZ)], where
%nMarkers corrisponds to the initial MLabels
%Implemented by Alice Mantoan, February 2013, <alice.mantoan@dei.unipd.it>

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



