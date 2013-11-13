function markerstrc = selectingMarkers(MarkersList,MLabels,markers)
%MarkersList: list of markers to print in the trc file
%MLabels: list of markers in the c3d file
%markers: struct of markers trajectories [nFrames x nMarkers*(XYZ)], where
%nMarkers corrisponds to the initial MLabels
%Implemented by Alice Mantoan, February 2013, <alice.mantoan@dei.unipd.it>

for i=1:length(MarkersList)
    j=MarkersList(i);
    
    z=strmatch(j,MLabels,'exact');
    
    if isempty(z)
        disp('Unfound marker: ')
        disp(j)
        error(['Marker to be written in the .trc file not found in the data. Check labeled data or your selection of markers for the trc file saved in the elaboration.xml'])
        
    else
        if i==1
            indexMarkerLabels=[z];
        else
            indexMarkerLabels=[indexMarkerLabels;z];
        end
    end
end

newMarkerLabels=[MLabels(indexMarkerLabels)];
   
markerstrc=[];

for i=1: length(newMarkerLabels)
    
    newindex=(indexMarkerLabels(i)-1)*3+1;
    markerstrc=[markerstrc markers(:,newindex:newindex+2)];
end

save_to_base(1)



