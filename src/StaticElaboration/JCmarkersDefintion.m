function  [inputMarkersNames,inputMarkersData]= JCmarkersDefintion(input,protocolMLabels,markers,jointTag)


if isfield(input,'MarkerNames') 
    
    for i=1:length(input.MarkerNames.Marker)
        
        inputMarkersNames{i}=input.MarkerNames.Marker(i);
        
        inputMarkersData{i}=selectingMarkers(inputMarkersNames{i},protocolMLabels,markers{1}(:,1:length(protocolMLabels)*3));
        
        if isempty(inputMarkersData{i})
            error(['Marker for ' jointTag ' JC computation not found: check markers labels defined in the JC method xml file with the markers set'])
        end
    end
    
else
    disp(['No markers are specified among input for ' jointTag ' JointCenter computation in static.xml file'])
    inputMarkersData=[];
    inputMarkersNames=[];
end
